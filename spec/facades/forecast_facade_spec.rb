require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    it '.get_forecast()' do
      VCR.use_cassette('forecast_facade_vcr') do
        location = 'Denver,CO'
        response = ForecastFacade.get_forecast(location)
        expect(response).to be_a(Forecast)
      end
    end
  end
end
