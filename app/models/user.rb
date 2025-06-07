class User < ApplicationRecord
    has_many :bulletins, class_name: "Bulletin", dependent: :destroy
end
