class TripsController < ApplicationController
  
  def index
  	#@movies = Movie.all.order("year_released ASC")
  	#@trips = Trip.find(params[:q])
  end

  def new
  	@trip = Trip.new
  	
  end

  def create
  	@trip = Trip.new(trip_params)

  	if @trip.save
  	  redirect_to @trip
  	else
  	  render :new
  	end
  end

  def show
  	@trip = Trip.find(params[:id])
  end

private
  def trip_params
  	params.require('trip').permit(:origin, :destination)
  end

end