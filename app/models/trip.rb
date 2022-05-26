class Trip < ApplicationRecord
  belongs_to :shuttle
  belongs_to :spatioport
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :bookings
  has_many :users, through: :bookings
  has_one_attached :photo
end
