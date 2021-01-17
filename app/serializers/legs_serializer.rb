class LegsSerializer < ActiveModel::Serializer
  attributes :id, :sport, :distanc, :aeg, :notes, :locations
  has_many :locations
end
