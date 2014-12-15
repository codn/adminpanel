require 'test_helper'

class GalleryUnitTest < Minitest::Test
  def test_gallery_position
    #load fixtures
    skip
    Adminpanel::Gallery.delete_all
    Adminpanel::Gallery.new.save(validate: false)
    Adminpanel::Gallery.new.save(validate: false)
    Adminpanel::Gallery.new.save(validate: false)

    first_gallery = Adminpanel::Gallery.first
    second_gallery = Adminpanel::Gallery.second
    third_gallery = Adminpanel::Gallery.third

    second_gallery.move_to_better_position
    assert_equal 1, second_gallery.position
    assert_equal 2, first_gallery.position
    assert_equal 3, third_gallery.position
  end
end
