class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end
  
  def show
  end
  
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save!
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end
  
  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :price_per_day, :min_duration)
  end
end
