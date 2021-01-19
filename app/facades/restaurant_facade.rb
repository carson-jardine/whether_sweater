class RestaurantFacade
  def self.get_restaurant(search_params)
    restaurant = RestaurantService.get_restaurant(search_params)
    Restaurant.new(restaurant)
  end
end
