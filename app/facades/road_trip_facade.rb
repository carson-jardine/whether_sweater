class RoadTripFacade
  def self.create_road_trip(trip_data)
    weather = weather_at_eta(trip_data)
    travel = travel_time(trip_data)
    RoadTrip.new(trip_data, travel, weather)
  end

  def self.weather_at_eta(trip_data)
    location = trip_data[:destination]
    forecast = ForecastFacade.get_forecast(location)
    # facades shouldn't know about each other
    hour_of_arrival = find_arrival_time(trip_data)
    if hour_of_arrival != 'Impossible Route'
      forecast_at_arrival = forecast.hourly_weather.find do |hourly|
        hourly[:time] == hour_of_arrival
      end
      {
        conditions: forecast_at_arrival[:conditions],
        temperature: forecast_at_arrival[:temperature]
      }
    end
  end

  def self.find_arrival_time(trip_data)
    current_time = Time.now.to_i
    travel_time = travel_time(trip_data)
    if travel_time[:real_time].nil? || travel_time[:real_time] >= 10000000
      return 'Impossible Route'
    else
      arrival = Time.strptime((current_time + travel_time[:real_time]).to_s, '%s').beginning_of_hour
      arrival.strftime('%T')
    end
  end

  def self.travel_time(trip_data)
    trip = MapQuestService.get_directions(trip_data)
    {
      formatted_time: trip[:route][:formattedTime],
      real_time: trip[:route][:realTime]
    }
  end
end
