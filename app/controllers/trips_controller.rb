class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end
end
