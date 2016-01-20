require 'test_helper'

module Adminpanel
  class ImageTest < ActiveSupport::TestCase
    test "creating an image should store the size and content_type" do
      uploader = Adminpanel::PhotoUploader.new(model: Adminpanel::Galleryfile)

      image = Adminpanel::Galleryfile.new(file: uploader)

      image.file.store! Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/hipster.jpg'), 'image/jpg')

      assert image.save
      assert_equal image.content_type, 'image/jpg'
      assert_equal image.file_size.to_i, 52196
    end

    test "updating a record with galleries should destroy old unassigned images of the same type" do
      unassigned_image = adminpanel_images(:unassigned)
      assert_not unassigned_image.nil?
      assert_equal 1, Adminpanel::Galleryfile.where(model: nil).count

      #trigger delete event
      gallery = adminpanel_galleries(:one).save

      assert_equal 0, Adminpanel::Galleryfile.where(model: nil).count
      assert_raise ActiveRecord::RecordNotFound do
        unassigned_image.reload
      end
    end
  end
end
