class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    if params[:end_date].nil? && params[:start_date].nil? && params[:destination].nil?
      @trips = Trip.all
    elsif (params[:end_date] == "" || params[:start_date] == "") && params[:destination].nil? == false
      destination = params[:destination].titleize
      @trips = Trip.where("destination = ?", destination)
    elsif params[:end_date].nil? == false && params[:start_date].nil? == false && params[:destination] == ""
      start_detail = params[:start_date].split("-")
      start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
      end_detail = params[:end_date].split("-")
      end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
      duration = (end_date - start_date).to_i
      @trips = Trip.where("min_duration < ?", duration)
    else
      start_detail = params[:start_date].split("-")
      start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
      end_detail = params[:end_date].split("-")
      end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
      duration = (end_date - start_date).to_i
      destination = params[:destination].titleize
      @trips = Trip.where("min_duration < ? and destination = ?", duration, destination)
    end
    session[:my_params] = params
  end

  def show
    session[:my_params]
    if session[:my_params]["start_date"].nil? == false
      start_detail = session[:my_params]["start_date"].split("-")
      @start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
    end
    if session[:my_params]["end_date"].nil? == false
      end_detail = session[:my_params]["end_date"].split("-")
      @end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
    end
    if session[:my_params]["start_date"].nil? == false && session[:my_params]["end_date"].nil? == false
      @duration = (@end_date - @start_date).to_i
    else
      @duration = 0
    end
    if session[:my_params]["number_of_travellers"].nil? == false
      @number = session[:my_params]["number_of_travellers"]
    end
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
    params.require(:trip).permit(:destination, :price_per_day, :min_duration, :photo)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
