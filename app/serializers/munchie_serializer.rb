class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attribute :restaurant_details do |restaurant|
    restaurant.restaurant_details
  end
end
