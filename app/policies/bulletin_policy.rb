class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || (@user && (@user == record.user || @user.admin?))
  end

  def create?
    @user.present?
  end

  def edit?
    @user && @user == record.user
  end

  def update?
    @user && @user == record.user
  end

  def to_moderation?
    @user && @user == record.user && record.draft?
  end

  def archive?
    @user && (@user == record.user || @user.admin?)
  end

  def publish?
    @user&.admin? && record.under_moderation?
  end

  def reject?
    @user&.admin? && record.under_moderation?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user&.admin?
        @scope.all
      elsif @user
        @scope.where(user: @user).or(@scope.where(state: "published"))
      else
        @scope.where(state: "published")
      end
    end
  end
end
