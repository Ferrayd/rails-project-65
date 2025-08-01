# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || user_is_owner_or_admin?
  end

  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def to_moderation?
    user_is_owner?
  end

  def archive?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record.user
  end

  def user_is_owner_or_admin?
    user == record.user || user.admin?
  end
end
