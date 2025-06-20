# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
