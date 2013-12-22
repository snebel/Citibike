module ApplicationHelper
  #require 'JSON'

  def get_stations
  	url = "https://citibikenyc.com/stations/json"
  	resp = Net::HTTP.get_response(URI.parse(url))
  	data = resp.body
  	result = JSON.parse(data)
  	result["stationBeanList"]
  end

  def closest_station_coords(lat, long)
    nearbys = Citibike.stations.all_within(lat, long, 2.5)
    if nearbys.empty?
      #flash error msg and redirect to homepage?
      return [nil, nil]
    else
      sta = closest_station_id(nearbys, lat, long)
      return [sta["latitude"], sta["longitude"]]
    end
  end

  #takes array of citibike stations
  def closest_station_id(nearbys, lat, long)
    dists = Hash.new #ids as keys, distances as vals
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
