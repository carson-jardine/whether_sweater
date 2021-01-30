require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes' do
    VCR.use_cassette('vail_road_trip') do
      origin = 'Denver,CO'
      destination = 'Vail,CO'
      trip_params = { origin: origin, destination: destination }
      weather_at_eta = RoadTripFacade.weather_at_eta(trip_params)
      travel_time = RoadTripFacade.travel_time(trip_params)
      result = RoadTrip.new(trip_params, travel_time, weather_at_eta)

      expect(result).to be_a(RoadTrip)

      expect(result.start_city).to eq(origin)

      expect(result.end_city).to eq(destination)

      expect(result.travel_time).to eq("01 hour(s), 39 minute(s)")

      expect(result.weather_at_eta).to be_a(Hash)

      expect(result.weather_at_eta).to have_key(:conditions)
      expect(result.weather_at_eta[:conditions]).to be_a(String)

      expect(result.weather_at_eta).to have_key(:temperature)
      expect(result.weather_at_eta[:temperature]).to be_a(Numeric)
    end
  end
end
