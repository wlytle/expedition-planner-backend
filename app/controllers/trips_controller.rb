class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:show]

  # GET /trips
  def index
    @trips = Trip.all.select { |trip| trip.users.includes(current_user) }

    render json: @trips.as_json(include: :legs, except: [:created_at, :updated_at])
  end

  # GET /trips/1
  def show
    render json: @trip
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)
    # default new trip to being uncompleted
    @trip.completed = false
    # create usertrip and assign current suer as cretor of this trip
    @trip.user_trips.build(user: current_user, accepted: true, created: true)

    if @trip.save
      render json: @trip.as_json(except: [:created_at, :updated_at]), status: :created, location: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name, :completed, :notes)
  end
end
