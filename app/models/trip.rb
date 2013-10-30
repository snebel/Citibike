class Trip < ActiveRecord::Base
  geocoded_by :origin, :latitude  => :origin_lat, 
  	:longitude => :origin_long

  geocoded_by :destination, :latitude => :destination_lat,
  	:longitude => :destination_long

  after_validation :geocode_both

  def geocode_both
  	orig = Geocoder.coordinates(self.origin)
    dest = Geocoder.coordinates(self.destination)
    self.origin_lat = orig.first
    self.origin_long = orig.last
    self.destination_lat = dest.first
    self.destination_long = dest.last
  end

  def find_closest_station

  end
end
