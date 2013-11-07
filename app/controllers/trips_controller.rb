class TripsController < ApplicationController
  #before_action :set_cookie, only: :new

  def set_location
    redirect_to new_trip_path unless cookies['lat_lng'].nil?
    flash[:notice] = "Please wait while we find your location...
    refresh the page if you are not redirected in a few seconds."
  end

  def index
    @trip = Trip.new
    # expire cookie here
  end

  def new
    @trip = Trip.new
    cookies["lat_lng"] ||= "40.741|-73.9898"
    if cookies["lat_lng"] == "40.741|-73.9898"
      @zoom = 14
    else
      @zoom = 16
    end
	  @lat_lng = cookies["lat_lng"].split("|")
    @lat = @lat_lng.first.to_f
    @lng = @lat_lng.last.to_f
    @sta = Trip.closest_station_coords(@lat, @lng)
    @sta_lat = @sta["latitude"]
    @sta_lng = @sta["longitude"]

  end

  def create
  	@trip = Trip.new(trip_params)
    #add these to the database instead?
    #used for getting station names on show page

  	if @trip.save
  	  redirect_to @trip
  	else
  	  render :new
  	end
  end

  def show
  	@trip = Trip.find(params[:id])
    @orig_sta = Trip.closest_station_coords(
      @trip.origin_lat, @trip.origin_long)
    @dest_sta = Trip.closest_station_coords(
      @trip.destination_lat, @trip.destination_long)
  end

private
  def trip_params
  	params.require('trip').permit(:origin, :destination)
  end

  def set_cookie

  end


end
