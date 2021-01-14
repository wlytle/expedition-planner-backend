class Trip < ApplicationRecord
  belongs_to :creator_id
  has_many :user_trips
  has_many :users, through: :user_trip
end
