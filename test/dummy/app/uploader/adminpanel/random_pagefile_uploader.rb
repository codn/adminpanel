module Adminpanel
  class RandomPagefileUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def root
      Rails.root.join 'public/'
    end

    def store_dir
      "uploads/image/#{model.class.name.demodulize}/#{model.id}"
    end

    version :thumb do
      process resize_to_fill: [120, 120]
    end

    def extension_white_list
      %w(jpg jpeg png)
    end
  end
end
