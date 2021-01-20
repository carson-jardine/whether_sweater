require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  before :each do
    email = 'test@example.com'
    password = 'password'
    user_params = { email: email, password: password, password_confirmation: password }

    @user = User.create!(user_params)

    login_params = {
      email: @user.email,
      password: password
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)
  end
  it 'returns roadtrip data', :vcr do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'

    road_trip_params = { origin: origin, destination: destination, api_key: @user.api_key }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    result = JSON.parse(response.body, symbolize_names: true)
    trip_data = result[:data]

    expect(trip_data).to have_key(:id)
    expect(trip_data[:id]).to eq(nil)

    expect(trip_data).to have_key(:type)
    expect(trip_data[:type]).to eq('roadtrip')

    expect(trip_data).to have_key(:attributes)
    expect(trip_data[:attributes]).to be_a(Hash)

    expect(trip_data[:attributes]).to have_key(:start_city)
    expect(trip_data[:attributes][:start_city]).to eq(origin)

    expect(trip_data[:attributes]).to have_key(:end_city)
    expect(trip_data[:attributes][:end_city]).to eq(destination)

    expect(trip_data[:attributes]).to have_key(:travel_time)
    expect(trip_data[:attributes][:travel_time]).to eq(nil)
    # TODO: put in a random time until I know actual data

    expect(trip_data[:attributes]).to have_key(:weather_at_eta)
    # expect(trip_data[:attributes][:weather_at_eta]).to be_a(Hash)

    # weather = trip_data[:attributes][:weather_at_eta]
    # expect(weather).to have_key(:temperature)
    # expect(weather[:temperature]).to eq(52.1)
    # TODO: put in a random temp until I know actual data

    # expect(weather).to have_key(:conditions)
    # expect(weather[:conditions]).to eq('partly cloudy with a chance of meatballs')
    # TODO: put in a random temp until I know actual data

  end
end

# Your response should have the following information for the front-end:
#
# a data attribute, under which all other attributes are present:
# id, always set to null
# type, always set to “roadtrip”
# attributes, an object containing road trip information:
# start_city, string, such as “Denver, CO”
# end_city, string, such as “Estes Park, CO”
# travel_time, string, something user-friendly like “2 hours, 13 minutes” or “2h13m” or “02:13:00” or something of that nature (you don’t have to include seconds); set this string to “impossible route” if there is no route between your cities
# weather_at_eta, conditions at end_city when you arrive (not CURRENT weather), object containing:
# temperature, numeric value in Fahrenheit
# conditions, string, as given by OpenWeather
# note: this object will be blank if the travel time is impossible
# eg:
#
# {
#   "data": {
#     "id": null,
#     "type": "roadtrip",
#     "attributes": {
#       "start_city": "Denver, CO",
#       "end_city": "Estes Park, CO",
#       "travel_time": "2 hours, 13 minutes"
#       "weather_at_eta": {
#         "temperature": 59.4,
#         "conditions": "partly cloudy with a chance of meatballs"
#       }
#     }
#   }
# }


# This POST endpoint should NOT call your endpoint like /api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=abc123, and should NOT send as form data either. You must send a JSON payload in the body of the request
# API key must be sent
# If no API key is given, or an incorrect key is provided, return 401 (Unauthorized)
# You will use MapQuest’s Directions API: https://developer.mapquest.com/documentation/directions-api/
# The structure of the response should be JSON API 1.0 Compliant.
# Your code should allow for the following:
# Traveling from New York, NY to Los Angeles, CA, with appropriate weather in L.A. when you arrive 40 hours later
# Traveling from New York, NY to London, UK, weather block should be empty and travel time should be “impossible”
