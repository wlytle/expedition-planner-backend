class Leg < ApplicationRecord
  belongs_to :Trip
  belongs_to :UserTrip
  has_many :locations
end
