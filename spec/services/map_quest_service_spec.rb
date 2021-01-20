require 'rails_helper'

RSpec.describe MapQuestService do
  describe 'class methods' do
    it '.get_coordinates()', :vcr do
      result = MapQuestService.get_coordinates('denver')
      expect(result).to be_a(Hash)
      expect(result).to have_key(:lat)
      expect(result[:lat]).to be_a(Float)
      expect(result).to have_key(:lng)
      expect(result[:lng]).to be_a(Float)
    end
    it '.get_directions()', :vcr do
      email = 'test@example.com'
      password = 'password'
      user_params = { email: email, password: password, password_confirmation: password }

      @user = User.create!(user_params)

      origin = 'Denver,CO'
      destination = 'Vail,CO'
      trip_params = { origin: origin, destination: destination }

      result = MapQuestService.get_directions(trip_params)

      expect(result).to be_a(Hash)

      expect(result).to have_key(:route)
      expect(result[:route]).to be_a(Hash)

      expect(result[:route]).to have_key(:formattedTime)
      expect(result[:route][:formattedTime]).to be_a(String)
    end
  end
end
