class MapQuestService
  def self.get_coordinates(location)
    response = conn.get('geocoding/v1/address') do |req|
      req.params[:location] = location
      req.params[:maxResults] = 1
    end
    data = parse_data(response)
    data[:results][0][:locations][0][:latLng]
  end

  def self.get_directions(trip_params)
    # origin_latLng = convert_to_latLng(trip_params[:origin])
    # destination_latLng = convert_to_latLng(trip_params[:destination])

    response = conn.get('directions/v2/route') do |req|
      req.params[:from] = trip_params[:origin]
      req.params[:to] = trip_params[:destination]
    end
    parse_data(response)
  end

  def self.convert_to_latLng(trip_param)
    get_coordinates(trip_param).values.join(',')
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |conn|
      conn.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
