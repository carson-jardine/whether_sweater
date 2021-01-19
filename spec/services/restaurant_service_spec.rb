require 'rails_helper'

RSpec.describe RestaurantService do
  describe 'When I enter a valid end location' do
    it 'Returns the name and address of a restaurant' do
      search_params = { destination: 'pueblo,co', categories: 'chinese' }
      result = RestaurantService.get_restaurant(search_params)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:businesses)
      expect(result[:businesses]).to be_an(Array)

      expect(result[:businesses][0]).to have_key(:name)
      expect(result[:businesses][0][:name]).to be_a(String)

      expect(result[:businesses][0]).to have_key(:is_closed)
      expect(result[:businesses][0][:is_closed]).to eq(false)

      expect(result[:businesses][0]).to have_key(:categories)
      expect(result[:businesses][0][:categories]).to be_an(Array)
      expect(result[:businesses][0][:categories][0]).to have_key(:title)
      expect(result[:businesses][0][:categories][0][:title]).to be_a(String)
      expect((result[:businesses][0][:categories][0][:title]).downcase).to eq((search_params[:categories]).downcase)

      expect(result[:businesses][0]).to have_key(:location)
      expect(result[:businesses][0][:location]).to be_a(Hash)
      expect(result[:businesses][0][:location]).to have_key(:display_address)
      expect(result[:businesses][0][:location][:display_address]).to be_an(Array)

    end
  end
end
