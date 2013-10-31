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

  def closest_station_name(lat, long)
  	nearbys = Citibike.stations.all_within(lat, long, 0.5)
  	s = closest_station_id(nearbys, lat, long)
  	return "#{s["latitude"]}, #{s["longitude"]}"
  end

  #takes array of citibike stations
  def closest_station_id(nearbys, lat, long)
  	dists = Hash.new
  	nearbys.each do |nearby|
  	  lats = lat - nearby["latitude"]
  	  longs = long - nearby["longitude"]
  	  dists[nearby["id"]] = Math.sqrt(lats*lats + longs*longs)
  	end

  	min = dists.values.min
  	id = dists.key(min)
  	Citibike.stations.find_by_id(id)
  end

end
