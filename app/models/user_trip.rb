class UserTrip < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :legs, dependent: :destroy
end
