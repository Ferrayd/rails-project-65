# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error
  validates :name, presence: true
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end
end
