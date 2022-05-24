class Shuttle < ApplicationRecord
  has_many :trips
  validates :max_capacity, :model, presence: true
end
