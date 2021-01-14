require 'test_helper'

class LegsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leg = legs(:one)
  end

  test "should get index" do
    get legs_url, as: :json
    assert_response :success
  end

  test "should create leg" do
    assert_difference('Leg.count') do
      post legs_url, params: { leg: { Trip_id: @leg.Trip_id, UserTrip_id: @leg.UserTrip_id, aeg: @leg.aeg, distance: @leg.distance, notes: @leg.notes, sport: @leg.sport } }, as: :json
    end

    assert_response 201
  end

  test "should show leg" do
    get leg_url(@leg), as: :json
    assert_response :success
  end

  test "should update leg" do
    patch leg_url(@leg), params: { leg: { Trip_id: @leg.Trip_id, UserTrip_id: @leg.UserTrip_id, aeg: @leg.aeg, distance: @leg.distance, notes: @leg.notes, sport: @leg.sport } }, as: :json
    assert_response 200
  end

  test "should destroy leg" do
    assert_difference('Leg.count', -1) do
      delete leg_url(@leg), as: :json
    end

    assert_response 204
  end
end
