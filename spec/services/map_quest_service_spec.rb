require 'rails_helper'

RSpec.describe MapQuestService do
  describe 'get coordinates' do
    it 'Address input returns lat/long coordinates', :vcr do
      result = MapQuestService.get_coordinates('denver')
      expect(result).to be_a(Hash)
      expect(result).to have_key(:lat)
      expect(result[:lat]).to be_a(Float)
      expect(result).to have_key(:lng)
      expect(result[:lng]).to be_a(Float)
    end
  end
end
