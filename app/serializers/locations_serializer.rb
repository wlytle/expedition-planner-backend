class LocationsSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :ele
end
