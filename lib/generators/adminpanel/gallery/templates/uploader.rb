module Adminpanel
  class <%= class_name %>Uploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick

    storage :file

    def root
      Rails.root.join 'public/'
    end

    def store_dir
      "uploads/image/#{model.class.name.demodulize}/#{model.id}"
    end

    # Process files as they are uploaded:
    # process :resize_to_fill => [1366, 768]

    # THE THUMB VERSION IS NECESSARY!!!!
    version :thumb do
      process :resize_to_limit => [80, 80]
    end

    # however, you can create your own versions:
    # version :awesome do
    #   process :reside_and_pad => [120, 900]
    # end

    # resize_and_pad(width, height, background=:transparent, gravity=::Magick::CenterGravity)
    #
    # Resize the image to fit within the specified dimensions while retaining
    # the original aspect ratio. If necessary, will pad the remaining area with
    # the given color, which defaults to transparent (for gif and png, white for jpeg).
    #
    # width (Integer)
    # the width to scale the image to
    # height (Integer)
    # the height to scale the image to
    # background (String, :transparent)
    # the color of the background as a hexcode, like “ff45de“
    # gravity (Magick::GravityType)
    # how to position the image

    # resize_to_fill(width, height)
    #
    # From the RMagick documentation: “Resize the image to fit within the
    # specified dimensions while retaining the aspect ratio of the original image.
    # If necessary, crop the image in the larger dimension.“
    #
    # See even www.imagemagick.org/RMagick/doc/image3.html#resize_to_fill
    #
    # width (Integer)
    # the width to scale the image to
    # height (Integer)
    # the height to scale the image to

    # resize_to_fit(width, height)
    #
    # From the RMagick documentation: “Resize the image to fit within the
    # specified dimensions while retaining the original aspect ratio. The image
    # may be shorter or narrower than specified in the smaller dimension but
    # will not be larger than the specified values.“
    #
    # See even www.imagemagick.org/RMagick/doc/image3.html#resize_to_fit
    #
    # width (Integer)
    # the width to scale the image to
    # height (Integer)
    # the height to scale the image to

    # resize_to_limit(width, height)
    #
    # Resize the image to fit within the specified dimensions while retaining
    # the original aspect ratio. Will only resize the image if it is larger than
    # the specified dimensions. The resulting image may be shorter or narrower
    # than specified in the smaller dimension but will not be larger than the
    # specified values.
    #
    # width (Integer)
    # the width to scale the image to
    # height (Integer)
    # the height to scale the image to
    def extension_white_list
      %w(jpg jpeg png)
    end
  end
end
