require 'rails_helper'

RSpec.describe 'Munchie Request' do
  describe 'When I input valid information' do
    it 'retrieves food and forecast info for a destination city', :vcr do
      start_city = 'denver,co'
      end_city = 'pueblo,co'
      food = 'chinese'
      get '/api/v1/munchies', params: { start: start_city, end: end_city, food: food }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      munchie_data = JSON.parse(response.body, symbolize_names: true)

      expect(munchie_data).to have_key(:id)
      expect(munchie_data[:id]).to eq(nil)

      expect(munchie_data).to have_key(:type)
      expect(munchie_data[:type]).to eq('munchie')

      expect(munchie_data).to have_key(:attributes)
      expect(munchie_data[:attributes]).to be_a(Hash)

      expect(munchie_data[:attributes]).to have_key(:destination_city)
      expect(munchie_data[:attributes][:destination_city]).to eq('Pueblo, CO')

      expect(munchie_data[:attributes]).to have_key(:travel_time)
      expect(munchie_data[:attributes][:travel_time]).to be_a(String)

      expect(munchie_data[:attributes]).to have_key(:forecast)
      expect(munchie_data[:attributes][:forecast]).to be_a(Hash)
      expect(munchie_data[:attributes][:forecast]).to have_key(:summary)
      expect(munchie_data[:attributes][:forecast][:summary]).to be_a(String)
      expect(munchie_data[:attributes][:forecast]).to have_key(:temperature)
      expect(munchie_data[:attributes][:forecast][:temperature]).to be_a(String)

      expect(munchie_data[:attributes]).to have_key(:restaurant)
      expect(munchie_data[:attributes][:restaurant]).to be_a(Hash)
      expect(munchie_data[:attributes][:restaurant]).to have_key(:name)
      expect(munchie_data[:attributes][:restaurant][:name]).to be_a(String)
      expect(munchie_data[:attributes][:restaurant]).to have_key(:address)
      expect(munchie_data[:attributes][:restaurant][:address]).to be_a(String)
    end
  end
end


# Your endpoint should follow this format:
# Your API will return:
# •	the destination city
# •	estimated travel time from start city to destination city
# •	the name and address of a restaurant serving THE SPECIFIED TYPE of cuisine that WILL BE OPEN at your estimated time of arrival.
# •	the current forecast of the destination city
# Your response should be in the format below:
# {
#   "data": {
#     "id": "null",
#     "type": "munchie",
#     "attributes": {
#       "destination_city": "Pueblo, CO",
#       "travel_time": "1 hours 48 min",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "83"
#       },
#       "restaurant": {
#         "name": "Chinese Restaurant",
#         "address": "4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008"
#       }
#     }
#   }
# }
