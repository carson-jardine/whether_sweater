class MapQuestService
  def self.get_coordinates(location)
    response = conn.get('address') do |req|
      req.params['location'] = location
      req.params['maxResults'] = 1
    end
    data = parse_data(response)
    data[:results][0][:locations][0][:latLng]
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1') do |conn|
      conn.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
