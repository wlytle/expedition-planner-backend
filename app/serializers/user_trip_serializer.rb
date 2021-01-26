class UserTripSerializer < ActiveModel::Serializer
  attributes :user_id, :accepted, :trip_id, :created
  has_many :legs, include: :id
end
