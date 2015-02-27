module Adminpanel
  class <%= class_name %>Uploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def root
      Rails.root.join 'public/'
    end

    def store_dir
      "uploads/image/#{model.class.name.demodulize}/#{model.id}"
    end

    # Process files as they are uploaded:
    # process resize_to_fill: [1366, 768]

    # 70 as a good default, make sure you know what's your priority
    process quality: 70

    # THE THUMB VERSION IS NECESSARY BY ADMINPANEL, DON'T REMOVE IT!!!!
    version :thumb do
      process resize_to_limit: [80, 80]
    end

    # however, you can create your own versions:
    # version :awesome do
    #   process reside_and_pad: [120, 900]
    # end

    # EXAMPLE:
    # original 300 x 300 (this is a square, thanks)
    #  _________________
    # |                 |
    # |        0        |
    # |       000       |
    # |        0        |
    # |       \|/       |
    # |        |        |
    # |       / \       |
    # |                 |
    # |_________________|

    # resize_and_pad: [700, 300] (fill with transparent to fit size.)
    #  __________________________________
    # |TTTTT|                     |TTTTT|
    # |TTTTT|          0          |TTTTT|
    # |TTTTT|         000         |TTTTT|
    # |TTTTT|          0          |TTTTT|
    # |TTTTT|         \|/         |TTTTT| => [700x300]
    # |TTTTT|          |          |TTTTT|
    # |TTTTT|         / \         |TTTTT|
    # |TTTTT|                     |TTTTT|
    # |_________________________________|

    # resize_to_fill: [700, 300] (force to fill zooming on the image, crops in half of the image)
    #  __________________________________
    # |      00000000000000000000       |
    # |         000000000000000         |
    # |              |||||              |
    # |      \\\\\\\\|||||///////       | => [700x300]
    # |      \\\\\\\\|||||///////       |
    # |              |||||              |
    # |              |||||              |
    # |_________________________________|

    # resize_to_fit: [120, 60] (resize to no larger than dimension, while
    #                             maintaining ratio)
    #  ____________
    # |            |
    # |     0      |
    # |     \/     |  => [60x60] (no larger than any, original ratio)
    # |     /|     |
    # |            |
    # |____________|

    #  resize_to_limit: [500, 500] resize_to_fit, but only resizing if original image is larger
    #  _________________
    # |                 |
    # |        0        |
    # |       000       |
    # |        0        |
    # |       \|/       | => [300, 300] (original)
    # |        |        |
    # |       / \       |
    # |                 |
    # |_________________|

    def extension_white_list
      %w(jpg jpeg png)
    end
  end
end
