class TripSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :name, :completed, :notes
  has_many :legs
  has_many :locations, through: :legs
end
