class ImageService
  def self.get_image(location)
    response = conn.get('photos') do |req|
      req.params['query'] = "downtown #{location}"
      req.params['per_page'] = 1
    end
    data = parse_data(response)
    data[:results][0]
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('https://api.unsplash.com/search') do |conn|
      conn.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
  end
end
