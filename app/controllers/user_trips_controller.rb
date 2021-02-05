class UserTripsController < ApplicationController
  before_action :set_user_trip, only: [:show]

  # GET /user_trips
  def index
    @user_trips = UserTrip.all

    render json: @user_trips
  end

  # GET /user_trips/1
  def show
    render json: @user_trip
  end

  # POST /user_trips
  def create
    @user_trip = UserTrip.new(user_trip_params)

    if @user_trip.save
      render json: @user_trip, status: :created, location: @user_trip
    else
      render json: @user_trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_trips/1
  def update
    @user_trip = UserTrip.find_by(user_id: current_user.id, trip_id: params[:id])
    @user_trip.accepted = true
    if @user_trip.save
      @trip = Trip.find(params[:id])
      render json: @user_trip
    else
      render json: @user_trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_trips/1
  def destroy
    @user_trip = UserTrip.find_by(user_id: current_user.id, trip_id: params[:id])
    @user_trip.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_trip
    @user_trip = UserTrip.find(params[:id])
  end

  # Only allow a trusted parameter
  def user_trip_params
    params.require(:user_trip).permit(:trip_id, :user_id, :accepted, :notes, :created)
  end
end
