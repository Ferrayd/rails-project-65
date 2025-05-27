module Admin
  class BasePolicy < Struct.new(:user, :record)
    def access?
      user&.admin?
    end
  end
end
