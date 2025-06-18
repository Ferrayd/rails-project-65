class AddAdmins < ActiveRecord::Migration[7.2]
  def change
      User.find_by(email: "kunitskiisv@gmail.com").update(admin: true)
  end
end
