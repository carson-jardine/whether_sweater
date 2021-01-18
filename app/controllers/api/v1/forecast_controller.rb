class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].blank?
      render json: { message: 'Please fill in a location' }, status: :not_found
    else
      forecast = ForecastFacade.get_forecast(params[:location])
      render json: ForecastSerializer.new(forecast)
    end 
  end
end
