# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[7.2]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false, limit: 50
      t.text :description, null: false, limit: 1000
      t.string :image, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
