class ForecastService
  def self.get_forecast(coords)
    response = conn.get('onecall') do |req|
      req.params['lat'] = coords[:lat]
      req.params['lon'] = coords[:lng]
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('https://api.openweathermap.org/data/2.5') do |conn|
      conn.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
    end
  end
end
