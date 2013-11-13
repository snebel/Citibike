class Place < ActiveRecord::Base
  validates_presence_of :name
  #validates_with AddressValidator

  belongs_to :user
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode
  
end
