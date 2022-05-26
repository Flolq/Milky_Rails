class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :booked]
  before_action :trip_details, only: [:show, :booked]

  def index
    @user = current_user
    if params[:end_date].blank? && params[:start_date].blank? && params[:destination].blank?
      @trips = Trip.all
    else
      start_detail = params[:start_date].split("-")
      start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
      end_detail = params[:end_date].split("-")
      end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
      duration = (end_date - start_date).to_i
      destination = params[:destination].titleize
      number_of_travellers = params[:number_of_travellers].to_i
      @trips = Trip.joins(:shuttle).where("min_duration < ? and destination = ? and max_capacity >= ?", (duration + 1), destination, (number_of_travellers))
    end
    session[:my_params] = params
    spatioports = @trips.map do |trip|
      trip.spatioport
    end
    @markers = spatioports.compact.map do |spatioport|
      {
        lat: spatioport.latitude,
        lng: spatioport.longitude,
        info_window: render_to_string(partial: "info_window", locals: { spatioport: spatioport }),
        image_url: helpers.asset_url("rocket.jpg")
      }
    end
  end

  def show
    @details = session[:my_params]
    spatioport = @trip.spatioport
    @markers = {
        lat: spatioport.latitude,
        lng: spatioport.longitude,
        info_window: render_to_string(partial: "info_window", locals: { spatioport: spatioport }),
        image_url: helpers.asset_url("rocket.jpg")
      }

  end


  def booked
    @user = current_user
  end

  def new
    @trip = Trip.new
    @user = current_user
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.owner = current_user

    if @trip.save!
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

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

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :price_per_day, :min_duration, :photo, :shuttle_id, :spatioport_id)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_details
    session[:my_params]
    if session[:my_params]["start_date"] != "" && !session[:my_params]["start_date"].nil?
      start_detail = session[:my_params]["start_date"].split("-")
      @start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
    end
    if session[:my_params]["end_date"] != "" && !session[:my_params]["end_date"].nil?
      end_detail = session[:my_params]["end_date"].split("-")
      @end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
    end
    if session[:my_params]["start_date"] != "" && !session[:my_params]["start_date"].nil? && session[:my_params]["end_date"] != "" && !session[:my_params]["end_date"].nil?
      @duration = (@end_date - @start_date).to_i
    else
      @duration = 0
    end
    if session[:my_params]["number_of_travellers"].nil? == false
      @number = session[:my_params]["number_of_travellers"]
    end
  end
end
