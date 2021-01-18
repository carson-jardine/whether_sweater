class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attribute :current_weather do |forecast|
    forecast.current_weather
  end

  attribute :daily_weather do |forecast|
    forecast.daily_weather.each do |day|
      day
    end
  end
  attribute :hourly_weather do |forecast|
    forecast.hourly_weather.each do |hour|
      hour
    end
  end
end
