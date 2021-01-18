require 'rails_helper'

RSpec.describe ImageService do
  describe 'When I enter a valid location' do
    it 'Returns an image', :vcr do
      result = ImageService.get_image('denver,co')
      expect(result).to be_a(Hash)
      expect(result).to have_key(:id)
      expect(result).to have_key(:description)

      expect(result).to have_key(:urls)
      expect(result[:urls]).to be_a(Hash)

      expect(result[:urls]).to have_key(:regular)
      expect(result[:urls][:regular]).to be_a(String)

      expect(result).to have_key(:user)
      expect(result[:user]).to be_a(Hash)

      expect(result[:user]).to have_key(:name)
      expect(result[:user][:name]).to be_a(String)

      expect(result[:user]).to have_key(:links)
      expect(result[:user][:links]).to be_a(Hash)
      expect(result[:user][:links]).to have_key(:self)
      expect(result[:user][:links][:self]).to be_a(String)
    end
  end
end
