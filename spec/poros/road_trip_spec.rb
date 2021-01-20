require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes', :vcr do
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

    expect(result.weather_at_eta).to eq({ conditions: "clear sky", temperature: 13.89})
  end
end
