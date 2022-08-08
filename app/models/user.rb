# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_exception

  validates :email, presence: true
  validates :name, presence: true
  validates :admin, inclusion: [true, false]
end
