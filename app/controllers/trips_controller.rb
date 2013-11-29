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
    #@stas = Trip.find_closest_stations(@lat, @lng)
  end

  def create
  	@trip = Trip.new(trip_params)

    if @trip.save
      redirect_to @trip
    else
      flash[:error] = @trip.errors.full_messages.join(",")
      redirect_to root_path
    end
  end

  def show
  	@trip = Trip.find(params[:id])
    @orig_stations = Trip.find_closest_stations(
                @trip.origin_lat, @trip.origin_long)
    @orig_sta = Trip.find_available_bike(@orig_stations)

    @dest_stations = Trip.find_closest_stations(
                @trip.destination_lat, @trip.destination_long)
    @dest_sta = Trip.find_available_dock(@dest_stations)
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to @trip
    else
      render :new
    end
  end

private
  def trip_params
  	params.require('trip').permit(:origin, :destination)
  end

end
