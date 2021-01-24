class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:show]

  # GET /trips
  def index
    user = current_user
    # @trips = current_user.trips

    # Query to get only accepted trips associated wiht the current user
    @trips = Trip.joins(:user_trips).where(user_trips: { accepted: true }).where(user_trips: { user_id: user.id })

    render json: @trips
  end

  # GET /invites
  #  gets all trips current_user has in user_trips that are not yet accepted
  def invites
    user = current_user

    # Query to get only not yet accepted trips associated wiht the current user
    @trips = Trip.joins(:user_trips).where(user_trips: { accepted: false }).where(user_trips: { user_id: user.id })
    render json: @trips
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
    # create usertrips for invited collaborators
    params[:trip][:collabs].each do |collab|
      @trip.user_trips.build(user_id: collab[:id], accepted: false, created: false)
    end

    if @trip.save
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip.as_json(include: :legs, except: [:created_at, :updated_at])
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

  # Only allow a trusted parameter.
  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name, :completed, :notes)
  end
end
