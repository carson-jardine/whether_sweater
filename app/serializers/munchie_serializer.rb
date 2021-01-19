class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attribute :restaurant_details do |restaurant|
    restaurant.restaurant_details
  end

  attribute :destination_city do |restaurant|
    restaurant.destination_city
  end
end
