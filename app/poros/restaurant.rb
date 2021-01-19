class Restaurant
  attr_reader :id,
              :restaurant_details,
              :destination_city

  def initialize(restaurant_data)
    @id = nil
    @restaurant_details = format_restaurant_return(restaurant_data)
    @destination_city = format_destination_city_return(restaurant_data)
  end

  def format_restaurant_return(restaurant_data)
    data = restaurant_data[:businesses][0]
    return {
      name: data[:name],
      address: data[:location][:display_address].join(', ')
    }
  end

  def format_destination_city_return(restaurant_data)
    "#{restaurant_data[:businesses][0][:location][:city]}, #{restaurant_data[:businesses][0][:location][:state]}"
  end
end
