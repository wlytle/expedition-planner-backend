class LegSerializer < ActiveModel::Serializer
  attributes :id, :sport, :distance, :aeg, :notes
  has_many :locations
end
