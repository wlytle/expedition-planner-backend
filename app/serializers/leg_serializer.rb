class LegSerializer < ActiveModel::Serializer
  attributes :id, :sport, :distance, :aeg, :notes, :start_date, :end_date
  has_many :locations
end
