class Place < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode
  
end
