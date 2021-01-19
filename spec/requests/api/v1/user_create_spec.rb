require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'Can create a user with a unique API key' do
    email = 'test@example.com'
    password = 'password'
    user_params = { email: email, password: password, password_confirmation: password }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    user = User.last
    expect(response).to be_successful
    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)
    result = result[:data]

    expect(result).to have_key(:id)
    expect(result[:id]).to eq(user.id.to_s)

    expect(result).to have_key(:type)
    expect(result[:type]).to eq('user')

    expect(result).to have_key(:attributes)
    expect(result[:attributes]).to be_a(Hash)

    expect(result[:attributes]).to have_key(:email)
    expect(result[:attributes][:email]).to eq(user.email)

    expect(result[:attributes]).to have_key(:api_key)
    expect(result[:attributes][:api_key]).to eq(user.api_key)
  end
  describe 'It will not create a new user if' do
    it 'passwords are not the same' do
      email = 'test@example.com'
      password = 'password'
      user_params = { email: email, password: password, password_confirmation: 'passwor' }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq('unsuccessful')

      expect(result).to have_key(:error)
      expect(result[:error]).to eq('Password confirmation doesn\'t match Password')
    end

    it 'email has already been taken' do
      email = 'test@example.com'
      password = 'password'
      user_params = { email: email, password: password, password_confirmation: password }

      user_1 = create(:user, user_params)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq('unsuccessful')

      expect(result).to have_key(:error)
      expect(result[:error]).to eq('Email has already been taken')
    end

    it 'any fields are left blank' do
      email = ''
      password = 'password'
      user_params = { email: email, password: password, password_confirmation: password }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq('unsuccessful')

      expect(result).to have_key(:error)
      expect(result[:error]).to eq('Email can\'t be blank')
    end
  end
end
