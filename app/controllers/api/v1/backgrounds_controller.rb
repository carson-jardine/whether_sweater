class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].blank?
      render json: { message: 'Please fill in a location' }, status: :not_found
    else
      image = ImageFacade.get_image(params[:location])
      render json: ImageSerializer.new(image)
    end
  end
end
