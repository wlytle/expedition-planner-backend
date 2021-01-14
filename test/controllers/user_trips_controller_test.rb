require 'test_helper'

class UserTripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_trip = user_trips(:one)
  end

  test "should get index" do
    get user_trips_url, as: :json
    assert_response :success
  end

  test "should create user_trip" do
    assert_difference('UserTrip.count') do
      post user_trips_url, params: { user_trip: { accepted: @user_trip.accepted, notes: @user_trip.notes, trip_id: @user_trip.trip_id, user_id: @user_trip.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show user_trip" do
    get user_trip_url(@user_trip), as: :json
    assert_response :success
  end

  test "should update user_trip" do
    patch user_trip_url(@user_trip), params: { user_trip: { accepted: @user_trip.accepted, notes: @user_trip.notes, trip_id: @user_trip.trip_id, user_id: @user_trip.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy user_trip" do
    assert_difference('UserTrip.count', -1) do
      delete user_trip_url(@user_trip), as: :json
    end

    assert_response 204
  end
end
