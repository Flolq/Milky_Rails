class BookingsController < ApplicationController
  def create
    # booking_params
    @booking = Booking.new
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    details = session[:my_params]
    start_detail = details["start_date"].split("-")
    start_date = Date.new(start_detail[0].to_i, start_detail[1].to_i, start_detail[2].to_i)
    end_detail = details["end_date"].split("-")
    end_date = Date.new(end_detail[0].to_i, end_detail[1].to_i, end_detail[2].to_i)
    @booking.start_date = start_date
    @booking.end_date = end_date
    @booking.number_of_people = details["number_of_travellers"]
    @booking.trip = @trip
    @booking.user = @user
    @booking.save
    redirect_to booked_path(@trip)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path(current_user)
  end


  private

  def booking_params
    # params.require(:booking).permit(:start_date, :end_date, :number_of_peole)
    params.require(:booking).permit(:start_date, :end_date, :number_of_peole)
  end
end
