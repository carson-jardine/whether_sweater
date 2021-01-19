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
  it 'returns roadtrip data' do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'

    road_trip_params = { origin: origin, destination: destination, api_key: @user.api_key }

    get '/api/v1/road_trip', params: road_trip_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    result = JSON.parse(response.body, symbolize_names: true)
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
