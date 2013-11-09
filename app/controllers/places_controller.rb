class PlacesController < ApplicationController

  def new
  	@place = Place.new
  end

  def create
  	@place = Place.new(place_params)
  	@place.user_id = current_user.id
  	if @place.save
  	  redirect_to root_path
  	else
  	  render :new
  	end
  end

  def show
	  @place = Place.find(params[:id])
    #cookies["lat_lng"] = "40.7411|-73.9898" #temp
	  @orig = cookies["lat_lng"].split('|')
    @lat = @orig.first.to_f
    @lng = @orig.last.to_f
    @orig_stas = Trip.find_closest_stations(@lat, @lng)
    @o_sta = Trip.find_available_bike(@orig_stas)
    @dest_stas = Trip.find_closest_stations(@place.lat, @place.lng)
    @d_sta = Trip.find_available_dock(@dest_stas)
  end

  def destroy
    redirect_to root_path
  end

private
  def place_params
  	params.require('place').permit(:name, :address)
  end

end