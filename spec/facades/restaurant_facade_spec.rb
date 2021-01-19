require 'rails_helper'

RSpec.describe RestaurantFacade do
  describe 'class methods' do
    it '.get_restaurant()' do
      search_params = { destination: 'Rye,NY', categories: 'asian' }

      response = RestaurantFacade.get_restaurant(search_params)
      expect(response).to be_a(Restaurant)
    end
  end
end
