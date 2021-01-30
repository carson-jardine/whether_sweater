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
    VCR.use_cassette('den_to_pueblo_road_trip') do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'

      road_trip_params = { origin: origin, destination: destination, api_key: @user.api_key.to_s }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

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
      expect(trip_data[:attributes][:travel_time]).to eq('01 hour(s), 44 minute(s)')

      expect(trip_data[:attributes]).to have_key(:weather_at_eta)
      expect(trip_data[:attributes][:weather_at_eta]).to be_a(Hash)

      weather = trip_data[:attributes][:weather_at_eta]
      expect(weather).to have_key(:temperature)
      expect(weather[:temperature]).to be_a(Numeric)

      expect(weather).to have_key(:conditions)
      expect(weather[:conditions]).to be_a(String)
    end
  end
  
  it 'route is not possible' do
    VCR.use_cassette('impossible_trip') do
      origin = 'Denver,CO'
      destination = 'Honolulu,HI'

      road_trip_params = { origin: origin, destination: destination, api_key: @user.api_key.to_s }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)
      trip_data = result[:data]

      expect(trip_data[:attributes][:travel_time]).to eq('Impossible Route')
    end
  end

  it 'returns an error when given an unauthorized API Key' do
    origin = 'Denver,CO'
    destination = 'Honolulu,HI'

    road_trip_params = { origin: origin, destination: destination, api_key: 'fake_key' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:message)
    expect(result[:message]).to eq('unsuccessful')

    expect(result).to have_key(:error)
    expect(result[:error]).to eq('Unauthorized API Key')
  end
end
