require 'rails_helper'

RSpec.describe 'Backgrounds Controller' do
  before :each do
    @location = 'Denver, CO'

    get '/api/v1/backgrounds', params: { location: @location }
    expect(response).to be_successful
    expect(response.status).to eq(200)

    image_data = JSON.parse(response.body, symbolize_names: true)
    @image_data = image_data[:data]
  end

  it 'I can get a background image based on the location params', :vcr do
    expect(@image_data).to have_key(:id)
    expect(@image_data[:id]).to eq(nil)

    expect(@image_data).to have_key(:type)
    expect(@image_data[:type]).to eq('image')

    expect(@image_data).to have_key(:attributes)
    expect(@image_data[:attributes]).to be_a(Hash)

    expect(@image_data[:attributes]).to have_key(:image)
    expect(@image_data[:attributes][:image]).to be_a(Hash)

    image = @image_data[:attributes][:image]
    expect(image).to have_key(:location)
    expect(image[:location]).to eq(@location)

    expect(image).to have_key(:image_url)
    expect(image).to have_key(:alt_text)

    expect(image).to have_key(:credit)
    expect(image[:credit]).to be_a(Hash)
    expect(image[:credit]).to have_key(:source)
    expect(image[:credit]).to have_key(:photographer)
  end
end
