module Adminpanel
  class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick
    # include CarrierWave::MiniMagick

    storage :file

    def root
      Rails.root.join 'public/'
    end

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/image/#{mounted_as}/#{model.id}"
    end

    # Process files as they are uploaded:
    # process :resize_to_fill => [1366, 768]

    # def scale(width, height)
    #   # do something
    # end
    # version :portfolio do
    #   process :resize_to_fill => [468, 312]
    # end

    # Create different versions of your uploaded files:
    version :thumb do
      process :resize_to_limit => [220, 220]
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg png)
    end
  end
end
