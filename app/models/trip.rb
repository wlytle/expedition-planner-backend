class Trip < ApplicationRecord
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips
  has_many :legs, dependent: :destroy
  has_many :locations, through: :legs
end
