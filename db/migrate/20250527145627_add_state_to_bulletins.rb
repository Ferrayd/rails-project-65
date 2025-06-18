# frozen_string_literal: true

class AddStateToBulletins < ActiveRecord::Migration[7.2]
  def change
    add_column :bulletins, :state, :string, default: 'draft', null: false
  end
end
