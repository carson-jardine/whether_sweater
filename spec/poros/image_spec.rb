require 'rails_helper'

RSpec.describe Image do
  it 'exists and has attributes', :vcr do
    location = 'Denver, CO'
    image = ImageService.get_image(location)
    result = Image.new(image, location)

    expect(result).to be_an(Image)
    image_result = result.image

    expect(image_result).to have_key(:location)
    expect(image_result[:location]).to eq(location)

    expect(image_result).to have_key(:image_url)
    expect(image_result[:image_url]).to be_a(String)

    expect(image_result).to have_key(:alt_text)
    expect(image_result[:alt_text]).to be_a(String)

    expect(image_result).to have_key(:credit)
    expect(image_result[:credit]).to be_a(Hash)

    expect(image_result[:credit]).to have_key(:source)
    expect(image_result[:credit][:source]).to be_a(String)

    expect(image_result[:credit]).to have_key(:photographer)
    expect(image_result[:credit][:photographer]).to be_a(String)
  end
end
