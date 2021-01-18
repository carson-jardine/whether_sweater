require 'rails_helper'

RSpec.describe 'Forecast Controller' do
  describe 'As a User' do
    describe 'When I enter valid coordinates' do
      before :each do
        coords = {:lat=>39.7625, :lng=>-104.9901}
        json = File.read('spec/fixtures/get_forecast.json')
        forecast_results = JSON.parse(json, symbolize_names: true)

        allow(CoordinateService).to receive(:get_coordinates).with('Denver,CO').and_return(coords)
        allow(ForecastService).to receive(:get_forecast).with(coords).and_return(forecast_results)

        location = 'Denver,CO'
        get api_v1_forecast_index_path, params: { location: location}
        expect(response).to be_successful
        expect(response.status).to eq 200

        forecast = JSON.parse(response.body, symbolize_names: true)
        @forecast = forecast[:data]
      end
      it 'returns forecast data' do
        expect(@forecast).to have_key(:id)
        expect(@forecast[:id]).to eq(nil)

        expect(@forecast).to have_key(:type)
        expect(@forecast[:type]).to eq('forecast')

        expect(@forecast).to have_key(:attributes)
        expect(@forecast[:attributes]).to be_a(Hash)

        expect(@forecast[:attributes]).to have_key(:current_weather)
        expect(@forecast[:attributes][:current_weather]).to be_a(Hash)

        expect(@forecast[:attributes]).to have_key(:daily_weather)
        expect(@forecast[:attributes][:daily_weather]).to be_an(Array)

        expect(@forecast[:attributes]).to have_key(:hourly_weather)
        expect(@forecast[:attributes][:hourly_weather]).to be_an(Array)
      end
    end
  end
end
