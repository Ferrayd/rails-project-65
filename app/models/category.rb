class Category < ApplicationRecord
    has_many :bulletins, dependent: :destroy
end
