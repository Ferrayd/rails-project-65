# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :category
  paginates_per 50
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg'],
                    size: { less_than: 5.megabytes, message: I18n.t('bulletin.validations.image_size') }

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
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at description id state title updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category user]
  end
end
