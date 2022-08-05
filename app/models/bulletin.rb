class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 15 }
  validates :image, presence: true
end
