# frozen_string_literal: true

class AddAdmins < ActiveRecord::Migration[7.2]
  def change
    User.find_by(email: 'vasiliqa13@gmail.com')&.update!(admin: true)
  end
end
