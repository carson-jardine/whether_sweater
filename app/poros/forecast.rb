class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = format_current_params(data[:current])
    @daily_weather = format_daily_params(data[:daily])
    @hourly_weather = format_hourly_params(data[:hourly])
  end

  def format_current_params(current_data)
    return {
      datetime: Time.at(current_data[:dt]),
      sunrise: Time.at(current_data[:sunrise]),
      sunset: Time.at(current_data[:sunset]),
      temperature: current_data[:temp],
      feels_like: current_data[:feels_like],
      humidity: current_data[:humidity],
      uvi: current_data[:uvi],
      visibility: current_data[:visibility],
      conditions: current_data[:weather][0][:description],
      icon: current_data[:weather][0][:icon]
    }
  end

  def format_daily_params(daily_data)
    daily_data[1..5].map do |day| {
      date: Time.at(day[:dt]).strftime('%D'),
      sunrise: Time.at(day[:sunrise]),
      sunset: Time.at(day[:sunset]),
      max_temp: day[:temp][:max],
      min_temp: day[:temp][:min],
      conditions: day[:weather][0][:description],
      icon: day[:weather][0][:icon]
    }
  end
end

def format_hourly_params(hourly_data)
  hourly_data[1..8].map do |hour| {
    time: Time.at(hour[:dt]).strftime('%T'),
    temperature: hour[:temp],
    wind_speed: "#{hour[:wind_speed]} mph",
    wind_direction: "from #{compass_dir[wind_dir(hour[:wind_deg])]}",
    conditions: hour[:weather][0][:description],
    icon: hour[:weather][0][:icon]
  }
end
end

def wind_dir(wind)
  (((wind % 360) / 22.5) + 0.5).round
end

def compass_dir
  return ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']
end
end
