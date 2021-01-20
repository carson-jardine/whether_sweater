class RoadTripFacade
  def self.create_road_trip(trip_data)
    weather = weather_at_eta(trip_data)
    travel = travel_time(trip_data)
    RoadTrip.new(trip_data, travel, weather)
  end

  def self.weather_at_eta(trip_data)
    require "pry"; binding.pry
    
    location = trip_data[:destination]
    forecast = ForecastFacade.get_forecast(location)
    hour_of_arrival = find_arrival_time(trip_data)
    forecast_at_arrival = forecast.hourly_weather.find do |hourly|
      hourly[:time] == hour_of_arrival
    end
    {
      conditions: forecast.hourly_weather[:conditions],
      temperature: forecast.hourly_weather[:temperature]
    }
  end

  def self.find_arrival_time(trip_data)
    current_time = Time.now.to_i
    travel_time = travel_time(trip_data)
    arrival = Time.strptime((current_time + travel_time[:real_time]).to_s, '%s').beginning_of_hour
    arrival.strftime('%T')
  end

  def self.travel_time(trip_data)
    trip = MapQuestService.get_directions(trip_data)
    {
      formatted_time: trip[:route][:formattedTime],
      real_time: trip[:route][:realTime]
    }
  end
end
