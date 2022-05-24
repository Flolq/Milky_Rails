class TripsController < ApplicationController
  before_action set_trip, only: [:show, :edit, :update, :destroy]
  def edit
  end

  def update
    @trip.update(trip_params)
    if @trip.save!
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
