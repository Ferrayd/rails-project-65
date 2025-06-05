class Bulletin < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validate :image_size_validation

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: [ :draft, :under_moderation, :published, :rejected ], to: :archived
    end
  end

  private

  def image_size_validation
    return unless image.attached?

    if image.blob.byte_size > 5.megabytes
      errors.add(:image, "должно быть меньше 5 МБ")
    end
  end
end
