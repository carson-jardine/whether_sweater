class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attribute :image do |object|
    object.image
  end
end
