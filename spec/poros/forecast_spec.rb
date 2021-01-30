require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    results = File.read('spec/fixtures/get_forecast.json')
    forecast = JSON.parse(results, symbolize_names: true)

    result = Forecast.new(forecast)
    expect(result).to be_a(Forecast)

    current = result.current_weather
    daily = result.daily_weather
    hourly = result.hourly_weather

    # current_data
    expect(current).to be_a(Hash)

    expect(current).to have_key(:datetime)
    expect(current[:datetime]).to be_a(Time)

    expect(current).to have_key(:sunrise)
    expect(current[:sunrise]).to be_a(Time)

    expect(current).to have_key(:sunset)
    expect(current[:sunset]).to be_a(Time)

    expect(current).to have_key(:temperature)
    expect(current[:temperature]).to eq(42.42)

    expect(current).to have_key(:feels_like)
    expect(current[:feels_like]).to eq(36.39)

    expect(current).to have_key(:humidity)
    expect(current[:humidity]).to eq(42)

    expect(current).to have_key(:uvi)
    expect(current[:uvi]).to eq(0)

    expect(current).to have_key(:visibility)
    expect(current[:visibility]).to eq(10000)

    expect(current).to have_key(:conditions)
    expect(current[:conditions]).to eq('broken clouds')

    expect(current).to have_key(:icon)
    expect(current[:icon]).to eq('04n')

    # daily data
    expect(daily).to be_an(Array)
    expect(daily.length).to eq(5)

    first = daily[0]
    expect(first).to have_key(:date)
    expect(first[:date]).to eq('01/18/21')

    expect(first).to have_key(:sunrise)
    expect(first[:sunrise]).to be_a(Time)

    expect(first).to have_key(:sunset)
    expect(first[:sunset]).to be_a(Time)

    expect(first).to have_key(:max_temp)
    expect(first[:max_temp]).to eq(42.04)

    expect(first).to have_key(:min_temp)
    expect(first[:min_temp]).to eq(28.44)

    expect(first).to have_key(:conditions)
    expect(first[:conditions]).to eq('clear sky')

    expect(first).to have_key(:icon)
    expect(first[:icon]).to eq('01d')

    # hourly data
    expect(hourly).to be_an(Array)
    expect(hourly.length).to eq(8)

    first = hourly[0]
    expect(first).to have_key(:time)
    expect(Time.parse(first[:time]).utc).to eq(Time.parse("20:00:00").utc)

    expect(first).to have_key(:temperature)
    expect(first[:temperature]).to eq(41.38)

    expect(first).to have_key(:wind_speed)
    expect(first[:wind_speed]).to eq('2.51 mph')

    expect(first).to have_key(:wind_direction)
    expect(first[:wind_direction]).to eq('from WSW')

    expect(first).to have_key(:conditions)
    expect(first[:conditions]).to eq('broken clouds')

    expect(first).to have_key(:icon)
    expect(first[:icon]).to eq('04n')
  end
end
