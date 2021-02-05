class LocationSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :ele, :leg_id
end
