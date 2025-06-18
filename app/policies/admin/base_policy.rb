# frozen_string_literal: true

module Admin
  BasePolicy = Struct.new(:user, :record) do
    def access?
      user&.admin?
    end
  end
end
