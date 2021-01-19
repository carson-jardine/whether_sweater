class Api::V1::MunchiesController < ApplicationController
  def index
    restaurant = RestaurantFacade.get_restaurant(restaurant_params)
    render json: MunchieSerializer.new(restaurant)
  end


  private

  def restaurant_params
    params.permit(:destination, :categories)
  end
end
