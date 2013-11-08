class AddressValidator < ActiveModel::Validator
  def validate(record)
    if Geocoder.coordinates(record.origin) == nil || 
   		Geocoder.coordinates(record.destination) == nil
      record.errors[:name] << 'That address is not geocodable!'
      #flash[:notice] = "Not geocodable!"
      #redirect_to root_path
    end
  end
end