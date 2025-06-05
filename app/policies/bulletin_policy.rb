class BulletinPolicy < ApplicationPolicy
  def update?
    user.present? && (record.user == user || user.admin?)
  end
end
