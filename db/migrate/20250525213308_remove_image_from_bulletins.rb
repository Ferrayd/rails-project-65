class RemoveImageFromBulletins < ActiveRecord::Migration[7.2]
  def change
    remove_column :bulletins, :image, :string
  end
end
