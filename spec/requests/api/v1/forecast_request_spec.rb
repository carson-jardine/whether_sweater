require 'rails_helper'

RSpec.describe 'Forecast Controller' do
  describe 'As a User' do
    describe 'When I enter valid coordinates' do
      before :each do
        json = File.read('spec/fixtures/get_forecast.json')
        forecast = JSON.parse(json, symbolize_names: true)

        allow(Api::V1::ForecastController).to receive
        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
        get '/api/v1/forecast?location=denver,co', headers: headers
        expect(response).to be_successful
        expect(response.status).to eq 200
        result = JSON.parse(response.body)
        @result = result['data']
      end
    end
  end
end
