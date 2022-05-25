class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :my_trips, class_name: 'Trip'
  has_many :trips, through: :booking
  validates :email, uniqueness: true
  has_one_attached :photo
end
