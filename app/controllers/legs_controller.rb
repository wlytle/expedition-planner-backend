class LegsController < ApplicationController
  before_action :set_leg, only: [:show, :update, :update_meta, :destroy]

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
    # Get usertrip
    @leg.user_trip = user_trip
    # get elevation data
    eles = get_ele params[:locs]
    # Build associated locations with leg
    params[:locs].each_with_index { |loc, i| @leg.locations.build(lat: loc[:lat], lng: loc[:lng], ele: eles[i]["height"]) }
    # initialize leg with same start and end dates as trip
    @leg.start_date = trip.start_date
    @leg.end_date = trip.end_date
    @leg.notes = ""

    # calculate aeg
    aeg = get_aeg eles
    # update leg with aeg
    @leg.aeg = aeg

    if @leg.save
      render json: @leg
    else
      render json: @leg.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /legs/1
  def update
    # Remove all previous leg lcoations and remake the path. With A LOT more time this could be made more efficient
    @leg.locations.destroy_all

    # get elevation data
    eles = get_ele params[:locs]
    params[:locs].each_with_index do |loc, i|
      eles[i] = 0 if eles[i] < -3000
      @leg.locations.build(lat: loc[:lat], lng: loc[:lng], ele: eles[i]["height"])
    end

    # calculate aeg
    aeg = get_aeg eles
    # update leg with aeg
    @leg.aeg = aeg

    # save the udpate and update the distance now saved in leg_params
    if @leg.update(leg_params)
      render json: @leg
    else
      render json: @leg.errors, status: :unprocessable_entity
    end
  end

  def update_meta
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
    params.require(:leg).permit(:trip_id, :user_trip_id, :sport, :distance, :aeg, :notes, :start_date, :end_date)
  end

  # Get elevation for locations from mapquest
  def get_ele(locs)
    key = ENV["MAP_QUEST"]
    trackStr = ""
    locs.each_with_index do |point, i|
      if i === locs.length - 1
        trackStr += "#{point[:lat]},#{point[:lng]}"
      else
        trackStr += "#{point[:lat]},#{point[:lng]},"
      end
    end

    response = Faraday.get "http://open.mapquestapi.com/elevation/v1/profile?key=#{key}&shapeFormat=raw&latLngCollection=#{trackStr}"

    return JSON.parse(response.body)["elevationProfile"]
  end
end

# Calcualte AEG
def get_aeg(eles)
  aeg = 0

  eles.each_with_index do |loc, i|
    if i != 0
      delta = loc["height"] - eles[i - 1]["height"]
      aeg += delta if delta > 0
    end
  end
  aeg
end
