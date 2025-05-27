class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validate :image_size_validation

  private

  def image_size_validation
    return unless image.attached?

    if image.blob.byte_size > 5.megabytes
      errors.add(:image, "должно быть меньше 5 МБ")
    end
  end
end
