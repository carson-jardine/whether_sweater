class ImageFacade
  def self.get_image(location)
    image = ImageService.get_image(location)
    Image.new(image, location)
  end
end
