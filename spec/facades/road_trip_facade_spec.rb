require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it '.create_road_trip()' do
      VCR.use_cassette('vail_road_trip') do
        origin = 'Denver,CO'
        destination = 'Vail,CO'
        trip_params = { origin: origin, destination: destination }
        road_trip = RoadTripFacade.create_road_trip(trip_params)

        expect(road_trip).to be_a(RoadTrip)
      end
    end
  end
end
