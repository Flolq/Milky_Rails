class Spatioport < ApplicationRecord
  has_many :trips

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
