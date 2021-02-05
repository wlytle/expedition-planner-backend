class Leg < ApplicationRecord
  belongs_to :trip
  belongs_to :user_trip
  has_many :locations, dependent: :destroy
end
