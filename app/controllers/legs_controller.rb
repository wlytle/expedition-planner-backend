class LegsController < ApplicationController
  before_action :set_leg, only: [:show, :update, :destroy]

  # GET /legs
  def index
    @legs = Leg.all

    render json: @legs
  end

  # GET /legs/1
  def show
    render json: @leg
  end

  # POST /legs
  def create
    @leg = Leg.new(leg_params)
    # Get associated trip
    trip = Trip.find(leg_params[:trip_id])
    # get user_trip to assign owner of leg
    user_trip = UserTrip.find_by(trip: trip, user: current_user)
    # GEt usertrip
    @leg.user_trip = user_trip
    # Build associated locations with leg
    params[:locs].each { |loc| @leg.locations.build(lat: loc[:lat], lng: loc[:lng]) }

    if @leg.save
      render json: @leg
    else
      render json: @leg.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /legs/1
  def update
    # # get length of lpolyline before and after update
    # params_len = params[:locs].length
    # locs_len = @leg.locations.length
    # # update locations while we have already made lcoations and new data with which to update
    # byebug
    # i = 0
    # while i < params_len && i < locs_len
    #   @leg.locations[i].update(lat: params[:locs][i][:lat], lng: params[:locs][i][:lng])
    #   i += 1
    # end

    # # make new lcoation data points for remianind data
    # if i < params_len
    #   while i < params_len
    #     @leg.locations.build(lat: params[:locs][i][:lat], lng: params[:locs][i][:lng])
    #     i += 1
    #   end
    #   # delete remaining locations that are no longer represented after the update
    # elsif i < locs_len
    #   while i < locs_len
    #     @leg.locations[i].delete
    #     i += 1
    #   end
    # end
    @leg.locations.destroy_all
    params[:locs].each { |loc| @leg.locations.build(lat: loc[:lat], lng: loc[:lng]) }
    # save the udpate and update the distance now saved in leg_params
    if @leg.update(leg_params)
      render json: @leg
    else
      render json: @leg.errors, status: :unprocessable_entity
    end
  end

  # DELETE /legs/1
  def destroy
    @leg.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leg
    @leg = Leg.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def leg_params
    params.require(:leg).permit(:trip_id, :user_trip_id, :sport, :distance, :aeg, :notes)
  end
end
