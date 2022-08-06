class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 15 }
  validates :image, attached: true, size: { less_than: 5.megabytes }, content_type: %i[png jpg jpeg]
end
