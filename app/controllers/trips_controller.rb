class TripsController < ApplicationController
  #before_action :set_cookie, only: :new
  
  def index
  	#@movies = Movie.all.order("year_released ASC")
  	#@trips = Trip.find(params[:q])
    redirect_to '/trips/new'

  end

  def new
    @trip = Trip.new
    if cookies["lat_lng"] == nil
      @lat_lng = [40.741, -73.9898]
      @lat = @lat_lng.first
      @lng = @lat_lng.last
      @sta = {}
      render :new
    else
  	  @lat_lng = cookies["lat_lng"].split("|")
      @lat = @lat_lng.first.to_f
      @lng = @lat_lng.last.to_f
      @sta = Trip.closest_station_coords(@lat, @lng)
      @sta_lat = @sta["latitude"]#@sta.first
      @sta_lng = @sta["longitude"]#@sta.last
    # expire cookie here
    end
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