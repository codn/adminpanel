# encoding: utf-8
module Adminpanel
  class ImageUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    include CarrierWave::RMagick
    # include CarrierWave::MiniMagick
    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    def root
      Rails.root.join 'public/'
    end

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/image/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    # process :resize_to_fill => [1366, 768]
    #
    # def scale(width, height)
    #   # do something
    # end
    version :portfolio do
      process :resize_to_fill => [468, 312]
    end

    # Create different versions of your uploaded files:
    version :thumb do
      process :resize_to_limit => [220, 220]
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg png)
    end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

  end
end
