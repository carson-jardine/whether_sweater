require 'rails_helper'

RSpec.describe 'Forecast Controller' do
  describe 'As a User' do
    describe 'When I enter valid coordinates' do
      before :each do
        coords = {:lat=>39.7625, :lng=>-104.9901}
        json = File.read('spec/fixtures/get_forecast.json')
        forecast_results = JSON.parse(json, symbolize_names: true)

        allow(MapQuestService).to receive(:get_coordinates).with('Denver,CO').and_return(coords)
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

        # current weather
        expect(@forecast[:attributes]).to have_key(:current_weather)
        expect(@forecast[:attributes][:current_weather]).to be_a(Hash)

        current_weather = @forecast[:attributes][:current_weather]
        expect(current_weather).to have_key(:datetime)
        expect(current_weather).to have_key(:sunrise)
        expect(current_weather).to have_key(:sunset)
        expect(current_weather).to have_key(:temperature)
        expect(current_weather).to have_key(:feels_like)
        expect(current_weather).to have_key(:humidity)
        expect(current_weather).to have_key(:uvi)
        expect(current_weather).to have_key(:visibility)
        expect(current_weather).to have_key(:conditions)
        expect(current_weather).to have_key(:icon)

        # daily weather
        expect(@forecast[:attributes]).to have_key(:daily_weather)
        expect(@forecast[:attributes][:daily_weather]).to be_an(Array)

        daily_weather = @forecast[:attributes][:daily_weather][0]
        expect(daily_weather).to have_key(:date)
        expect(daily_weather).to have_key(:sunrise)
        expect(daily_weather).to have_key(:sunset)
        expect(daily_weather).to have_key(:max_temp)
        expect(daily_weather).to have_key(:min_temp)
        expect(daily_weather).to have_key(:conditions)
        expect(daily_weather).to have_key(:icon)

        # hourly weather
        expect(@forecast[:attributes]).to have_key(:hourly_weather)
        expect(@forecast[:attributes][:hourly_weather]).to be_an(Array)

        hourly_weather = @forecast[:attributes][:hourly_weather][0]
        expect(hourly_weather).to have_key(:time)
        expect(hourly_weather).to have_key(:temperature)
        expect(hourly_weather).to have_key(:wind_speed)
        expect(hourly_weather).to have_key(:wind_direction)
        expect(hourly_weather).to have_key(:conditions)
        expect(hourly_weather).to have_key(:icon)
      end

      it 'does not return any fields that should not be present' do
        expect(@forecast[:attributes]).to have_key(:current_weather)
        current_weather = @forecast[:attributes][:current_weather]
        expect(current_weather).to_not have_key(:dt)
        expect(current_weather).to_not have_key(:temp)
        expect(current_weather).to_not have_key(:weather)

        expect(@forecast[:attributes]).to have_key(:daily_weather)
        daily_weather = @forecast[:attributes][:daily_weather][0]
        expect(daily_weather).to_not have_key(:dt)
        expect(daily_weather).to_not have_key(:temp)
        expect(daily_weather).to_not have_key(:weather)

        expect(@forecast[:attributes]).to have_key(:hourly_weather)
        hourly_weather = @forecast[:attributes][:hourly_weather][0]
        expect(hourly_weather).to_not have_key(:dt)
        expect(hourly_weather).to_not have_key(:temp)
        expect(hourly_weather).to_not have_key(:wind_deg)
        expect(hourly_weather).to_not have_key(:weather)
      end
    end
    describe 'No results are returned' do
      it 'When given no location' do
        location = ''
        get '/api/v1/forecast', params: { location: location }
        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error_message = JSON.parse(response.body, symbolize_names: true)
        expect(error_message[:message]).to eq('Please fill in a location')
      end
    end
  end
end
