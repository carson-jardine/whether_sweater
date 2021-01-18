class Image
  attr_reader :id,
              :image

  def initialize(data, location)
    @id = nil
    @image = format_image_return(data, location)
  end

  def format_image_return(data, location)
    return {
      location: location,
      image_url: data[:urls][:regular],
      alt_text: data[:description],
      credit: {
        source: 'unsplash.com',
        photographer: data[:user][:name]
      }
    }
  end
end
