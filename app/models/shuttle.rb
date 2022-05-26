class Shuttle < ApplicationRecord
  has_many :trips
  has_one_attached :photo
  validates :max_capacity, :model, presence: true
end
