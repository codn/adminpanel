require 'test_helper'
module Adminpanel
  class GalleryzableTest < ActiveSupport::TestCase

    def test_sortable_funcionallity
      gallery = Adminpanel::Gallery.first
      assert_equal 1, gallery.position

      gallery.move_to_position(2)
      assert_equal 2, gallery.position

      assert_not_equal Adminpanel::Gallery.first, gallery

      Adminpanel::Gallery.find_by_position(3).move_to_position(1)
      assert_equal Adminpanel::Gallery.last, gallery
    end

  end
end
