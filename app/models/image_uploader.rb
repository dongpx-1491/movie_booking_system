class ImageUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/jpg image/png image/webp]
    validate_extension_inclusion %w[jpg jpeg png webp]
    validate_max_size  10*1024*1024
  end
end
