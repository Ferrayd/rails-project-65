# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, class_name: 'Bulletin', dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name email uid provider admin created_at updated_at]
  end
end
