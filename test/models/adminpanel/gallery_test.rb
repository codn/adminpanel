require 'test_helper'
module Adminpanel
  class GalleryTest < ActiveSupport::TestCase

    def test_sortable_funcionallity
      gallery = Adminpanel::Gallery.first
      assert_equal 1, gallery.position

      gallery.move_to_better_position
      assert_equal 1, gallery.position

      gallery.move_to_worst_position
      assert_equal 2, gallery.position

      assert_not_equal Adminpanel::Gallery.first, gallery

      Adminpanel::Gallery.find_by_position(3).move_to_better_position
      assert_equal Adminpanel::Gallery.last, gallery

      gallery.reload
      assert_equal 3, gallery.position

      gallery.move_to_worst_position
      assert_equal 3, gallery.position
    end

  end
end
