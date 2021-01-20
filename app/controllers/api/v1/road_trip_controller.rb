class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip_data = JSON.parse(request.body.string, symbolize_names: true)

    user = User.find_by(api_key: road_trip_data[:api_key])
    if user
      trip_params = { origin: road_trip_data[:origin], destination: road_trip_data[:destination] }
      road_trip = RoadTripFacade.create_road_trip(trip_params)
      render json: RoadTripSerializer.new(road_trip)
    end
  end
end
