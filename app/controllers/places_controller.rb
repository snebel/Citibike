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
	  @orig = cookies["lat_lng"]
  end

=begin not being used
  def show_station
    @place = place.new
    @place.address = 
    @orig = cookies["lat_lng"]
  end
=end

private
  def place_params
  	params.require('place').permit(:name, :address)
  end

end