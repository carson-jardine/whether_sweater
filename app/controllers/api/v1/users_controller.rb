class Api::V1::UsersController < ApplicationController
  def create
    user_data = JSON.parse(request.body.string, symbolize_names: true)
    user = User.create({
              email: user_data[:email],
              password: user_data[:password],
              password_confirmation: user_data[:password_confirmation]
      })
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { message: 'unsuccessful', error: user.errors.full_messages.to_sentence.to_s }, status: :unprocessable_entity
    end
  end
end
