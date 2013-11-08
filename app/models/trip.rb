class Trip < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with AddressValidator
  #need to validate origin and destination as being geocodable

  geocoded_by :origin, :latitude  => :origin_lat, 
  	:longitude => :origin_long

  geocoded_by :destination, :latitude => :destination_lat,
  	:longitude => :destination_long

  after_validation :geocode_all
  #scope :closest_station_coords

  def geocode_all
  	orig = Geocoder.coordinates(self.origin)
    dest = Geocoder.coordinates(self.destination)
    self.origin_lat = orig.first
    self.origin_long = orig.last
    self.destination_lat = dest.first
    self.destination_long = dest.last

    orig_sta = Trip.closest_station_coords(origin_lat, origin_long)
    self.origin_closest_station_lat = orig_sta["latitude"]#orig_sta.first
    self.origin_closest_station_long = orig_sta["longitude"]#orig_sta.last

    dest_sta = Trip.closest_station_coords(destination_lat, destination_long)
    self.dest_closest_station_lat = dest_sta["latitude"]#dest_sta.first
    self.dest_closest_station_long = dest_sta["longitude"]#dest_sta.last
  end

  #returns a station object!
  def self.closest_station_coords(lat, long)
  	nearbys = Citibike.stations.all_within(lat, long, 2.5)
  	if nearbys.empty?
  	  #flash error msg and redirect to homepage?
  	  return [nil, nil]
  	else
  	  sta = closest_station_id(nearbys, lat, long)
  	  #return [sta["latitude"], sta["longitude"]]
  	end
  end

  #takes array of citibike stations
  def self.closest_station_id(nearbys, lat, long)
  	dists = Hash.new #ids as keys, distances as vals
  	nearbys.each do |nearby|
  	  lats = lat - nearby["latitude"]
  	  longs = long - nearby["longitude"]
  	  dists[nearby["id"]] = Math.sqrt(lats*lats + longs*longs)
  	end

  	min = dists.values.min
  	id = dists.key(min)
  	Citibike.stations.find_by_id(id)

  	#if sta["availableBikes"] < 14 #or docks == 0
  	#  nearbys.delete(sta)
  	#  closest_station_id(nearbys, lat, long)
  	#else
  	#  return sta
  	#end
  end

end
