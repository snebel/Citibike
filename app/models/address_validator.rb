# I know you can get this working! 
class AddressValidator < ActiveModel::Validator
  def validate(record)

    if true
    # if Geocoder.coordinates(record.origin) == nil #|| 
   		#Geocoder.coordinates(record.destination) == nil
   	#also validate for Citibike.stations.all_within(origin.lat, origin.lng, 0.5)
   	#Citibike.stations.all_within(dest.lat, dest.lng, 0.5) not being empty
      record.errors[:origin] << 'That address is not geocodable!'
      #
      #flash[:notice] = "Not geocodable!"
      #redirect_to root_path

    end
  end
end
