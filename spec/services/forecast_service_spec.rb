require 'rails_helper'

RSpec.describe ForecastService do
  describe 'get forecast' do
    it 'Returns forecast parsed', :vcr do
      coords = {:lat=>39.7625, :lng=>-104.9901}
      result = ForecastService.get_forecast(coords)

      expect(result).to have_key(:current)
      expect(result).to have_key(:hourly)
      expect(result).to have_key(:daily)

      current_forecast = result[:current]
      hourly_forecast = result[:hourly][0]
      daily_forecast = result[:daily][0]

      expect(current_forecast).to be_a(Hash)
      expect(hourly_forecast).to be_a(Hash)
      expect(daily_forecast).to be_a(Hash)

      # current_forecast
      expect(current_forecast).to have_key(:dt)
      expect(current_forecast[:dt]).to be_a(Numeric)

      expect(current_forecast).to have_key(:sunrise)
      expect(current_forecast[:sunrise]).to be_a(Numeric)

      expect(current_forecast).to have_key(:sunset)
      expect(current_forecast[:sunset]).to be_a(Numeric)

      expect(current_forecast).to have_key(:temp)
      expect(current_forecast[:temp]).to be_a(Float)

      expect(current_forecast).to have_key(:feels_like)
      expect(current_forecast[:feels_like]).to be_a(Float)

      expect(current_forecast).to have_key(:humidity)
      expect(current_forecast[:humidity]).to be_a(Numeric)

      expect(current_forecast).to have_key(:uvi)
      expect(current_forecast[:uvi]).to be_a(Numeric)

      expect(current_forecast).to have_key(:visibility)
      expect(current_forecast[:visibility]).to be_a(Numeric)

      expect(current_forecast).to have_key(:weather)
      expect(current_forecast[:weather]).to be_an(Array)
      expect(current_forecast[:weather][0]).to have_key(:description)
      expect(current_forecast[:weather][0][:description]).to be_a(String)
      expect(current_forecast[:weather][0]).to have_key(:icon)
      expect(current_forecast[:weather][0][:icon]).to be_a(String)

      # daily_forecast

      expect(daily_forecast).to have_key(:dt)
      expect(daily_forecast[:dt]).to be_a(Numeric)

      expect(daily_forecast).to have_key(:sunrise)
      expect(daily_forecast[:sunrise]).to be_a(Numeric)

      expect(daily_forecast).to have_key(:sunset)
      expect(daily_forecast[:sunset]).to be_a(Numeric)

      expect(daily_forecast).to have_key(:temp)
      expect(daily_forecast[:temp]).to be_a(Hash)
      expect(daily_forecast[:temp]).to have_key(:max)
      expect(daily_forecast[:temp][:max]).to be_a(Float)
      expect(daily_forecast[:temp]).to have_key(:min)
      expect(daily_forecast[:temp][:min]).to be_a(Float)

      expect(daily_forecast).to have_key(:weather)
      expect(daily_forecast[:weather]).to be_an(Array)
      expect(daily_forecast[:weather][0]).to have_key(:description)
      expect(daily_forecast[:weather][0][:description]).to be_a(String)
      expect(daily_forecast[:weather][0]).to have_key(:icon)
      expect(daily_forecast[:weather][0][:icon]).to be_a(String)

      # hourly_forecast
      expect(hourly_forecast).to have_key(:dt)
      expect(hourly_forecast[:dt]).to be_a(Numeric)

      expect(hourly_forecast).to have_key(:temp)
      expect(hourly_forecast[:temp]).to be_a(Float)

      expect(hourly_forecast).to have_key(:wind_speed)
      expect(hourly_forecast[:wind_speed]).to be_a(Float)

      expect(hourly_forecast).to have_key(:wind_deg)
      expect(hourly_forecast[:wind_deg]).to be_an(Integer)

      expect(hourly_forecast).to have_key(:weather)
      expect(hourly_forecast[:weather]).to be_an(Array)
      expect(hourly_forecast[:weather][0]).to have_key(:description)
      expect(hourly_forecast[:weather][0][:description]).to be_a(String)
      expect(hourly_forecast[:weather][0]).to have_key(:icon)
      expect(hourly_forecast[:weather][0][:icon]).to be_a(String)

    end
  end
end
