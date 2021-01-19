require 'rails_helper'

RSpec.describe 'Sessions Controller' do
  describe 'logging in' do
    before :each do
      email = 'test@example.com'
      password = 'password'
      user_params = { email: email, password: password, password_confirmation: password }

      @user = User.create!(user_params)
    end
    it 'a user can log in with valid credentials' do
      login_params = {
        email: @user.email,
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)
      login_result = result[:data]

      expect(login_result).to have_key(:id)
      expect(login_result[:id]).to eq(@user.id.to_s)

      expect(login_result).to have_key(:type)
      expect(login_result[:type]).to eq('user')

      expect(login_result).to have_key(:attributes)
      expect(login_result[:attributes]).to be_a(Hash)

      expect(login_result[:attributes]).to have_key(:email)
      expect(login_result[:attributes][:email]).to eq(@user.email)

      expect(login_result[:attributes]).to have_key(:api_key)
      expect(login_result[:attributes][:api_key]).to eq(@user.api_key)

      expect(login_result).to_not have_key(:password)
      expect(login_result).to_not have_key(:password_digest)
    end

    it 'user gets generalized error when wrong email or password is entered' do
      login_params = {
        email: 'wrong@example.com',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq('unsuccessful')

      expect(result).to have_key(:error)
      expect(result[:error]).to eq('Invalid credentials')
    end
    it 'user gets error if field is left blank' do
      login_params = {
        email: '',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq('unsuccessful')

      expect(result).to have_key(:error)
      expect(result[:error]).to eq('Fields can\'t be blank')
    end
  end
end
