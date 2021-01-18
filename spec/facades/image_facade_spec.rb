require 'rails_helper'

RSpec.describe ImageFacade do
  describe 'class methods' do
    it '.get_image()', :vcr do
      location = 'Denver,CO'
      response = ImageFacade.get_image(location)
      expect(response).to be_an(Image)
    end
  end
end
