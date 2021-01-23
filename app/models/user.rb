class User < ApplicationRecord
  has_many :user_trips, dependent: :destroy
  has_many :trips, through: :user_trips
  has_secure_password
  validates :user_name, uniqueness: { case_sensitive: true, message: "%{value} is already taken" }
end
