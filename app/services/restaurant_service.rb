class RestaurantService
  def self.get_restaurant(search_params)
    response = conn.get('/v3/businesses/search') do |req|
      req.params[:location] = search_params[:destination]
      req.params[:open_now] = true
      req.params[:term] = 'restaurant'
      req.params[:categories] = search_params[:categories]
      req.params[:limit] = 1
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn

    Faraday.new('https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']} "
    end
  end
end
