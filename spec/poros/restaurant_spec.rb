require 'rails_helper'

RSpec.describe Restaurant do
  it 'exists and has attributes' do
    search_params = { destination: 'pueblo,co', categories: 'chinese' }
    restaurant = RestaurantService.get_restaurant(search_params)
    result = Restaurant.new(restaurant)

    expect(result).to be_an(Restaurant)
    restaurant_result = result.restaurant_details

    expect(restaurant_result).to have_key(:restaurant)
    expect(restaurant_result[:restaurant]).to be_a(Hash)

    expect(restaurant_result[:restaurant]).to have_key(:name)
    expect(restaurant_result[:restaurant][:name]).to be_a(String)

    expect(restaurant_result[:restaurant]).to have_key(:address)
    expect(restaurant_result[:restaurant][:address]).to be_a(String)
  end
end
