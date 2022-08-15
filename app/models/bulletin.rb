# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 15 }
  validates :image, attached: true, size: { less_than: 5.megabytes }, content_type: %i[png jpg jpeg]

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :sent_for_moderation do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end

  scope :published, -> { where(state: :published) }
end
