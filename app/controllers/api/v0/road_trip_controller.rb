class Api::V0::RoadTripController < ApplicationController

  def create
    @user = User.find_by(api_key: params[:api_key])

    if @user.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    else
      road_trip_facade = RoadTripFacade.new
      road_trip = road_trip_facade.receive_directions(params["origin"], params["destination"])

      if road_trip.travel_time.nil?
        render json: { error: 'Invalid trip request' }, status: :bad_request
      else
        render json: RoadTripSerializer.new(road_trip), status: :ok
      end
    end
  end
end
