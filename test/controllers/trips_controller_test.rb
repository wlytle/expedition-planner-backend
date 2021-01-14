require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get trips_url, as: :json
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post trips_url, params: { trip: { completed: @trip.completed, creator_id_id: @trip.creator_id_id, end_date: @trip.end_date, name: @trip.name, notes: @trip.notes, start_date: @trip.start_date } }, as: :json
    end

    assert_response 201
  end

  test "should show trip" do
    get trip_url(@trip), as: :json
    assert_response :success
  end

  test "should update trip" do
    patch trip_url(@trip), params: { trip: { completed: @trip.completed, creator_id_id: @trip.creator_id_id, end_date: @trip.end_date, name: @trip.name, notes: @trip.notes, start_date: @trip.start_date } }, as: :json
    assert_response 200
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete trip_url(@trip), as: :json
    end

    assert_response 204
  end
end
