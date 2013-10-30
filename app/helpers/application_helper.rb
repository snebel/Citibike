module ApplicationHelper
  #require 'JSON'

  def get_stations
  	url = "https://citibikenyc.com/stations/json"
  	resp = Net::HTTP.get_response(URI.parse(url))
  	data = resp.body
  	result = JSON.parse(data)
  	result["stationBeanList"]
  end

=begin
  def nearest_station(lat, lng)
  	stations = get_stations
  	d = []
  	stations.each do |s|
  	  d << sqrt( (lat - s["latitude"])*(lat - s["latitude"]) + (lat - s["longitude"])*(lat - s["longitude"]) )
  	end

  	return stations[d.minimum.index]
  end
=end
end
