class Trip < ActiveRecord::Base
  #validates_presence_of :origin

  include ActiveModel::Validations
  #validates_with AddressValidator
  #need to validate origin and destination as being geocodable

  geocoded_by :origin, :latitude  => :origin_lat, 
  	:longitude => :origin_long

  geocoded_by :destination, :latitude => :destination_lat,
  	:longitude => :destination_long

  before_save :geocode_all

  def geocode_all
  	orig = Geocoder.coordinates(self.origin)
    dest = Geocoder.coordinates(self.destination)
    self.origin_lat = orig.first
    self.origin_long = orig.last
    self.destination_lat = dest.first
    self.destination_long = dest.last
  end

  # returns array of Stations sorted by distance from lat, long
  def self.find_closest_stations(lat, long)
  	nearbys = Citibike.stations.all_within(lat, long, 0.3)
    dists = {}
    nearbys.each do |sta|
      dists[sta.id] = sta.distance_from(lat, long)
  	end

    dists = dists.sort_by { |id, distance| distance }
    sorted_nearbys = []
    dists.each do |id, distance|
      sorted_nearbys << Citibike.stations.find_by_id(id)
    end

    return sorted_nearbys
  end

  #stations is array of stations sorted by distance
  def self.find_available_bike(stations)
    stations.each do |sta|
      if sta.available_bikes > 1 && sta.status == "Active"
        return sta
      end
    end
    stations.empty? ? nil : stations[0]
  end

  def self.find_available_dock(stations)
    stations.each do |sta|
      if sta.available_docks > 1 && sta.status == "Active"
        return sta
      end
    end
    stations.empty? ? nil : stations[0]
  end

end
