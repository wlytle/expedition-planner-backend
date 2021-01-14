class User < ApplicationRecord
  has_many :user_trips
  has_many :trips, through: :user_trip
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
end
