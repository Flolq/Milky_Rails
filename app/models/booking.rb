class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  validates :start_date, :end_date, :number_of_people, presence: true
end
