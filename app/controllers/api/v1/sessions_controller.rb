class Api::V1::SessionsController < ApplicationController
  def create
    login_data = JSON.parse(request.body.string, symbolize_names: true)

    user = User.find_by(email: login_data[:email])
    if user&.authenticate(login_data[:password])
      render json: UserSerializer.new(user)
    elsif login_data[:email].blank? || login_data[:password].blank?
      render json: { message: 'unsuccessful', error: 'Fields can\'t be blank'}, status: :unprocessable_entity
    else
      render json: { message: 'unsuccessful', error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
