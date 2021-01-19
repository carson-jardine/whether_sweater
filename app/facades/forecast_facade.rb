class ForecastFacade
  def self.get_forecast(location)
    coords = MapQuestService.get_coordinates(location)
    forecast = ForecastService.get_forecast(coords)
    Forecast.new(forecast)
  end
end
