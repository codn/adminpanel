require 'test_helper'
module Adminpanel
  class SortableUnitTest < ActiveSupport::TestCase

    setup :instance_objects

    def test_has_and_ordered_scope
      gallery = Adminpanel::Gallery.all.ordered
      assert_equal [1,2,3], gallery.pluck(:position)
    end

    def test_creation_callback

      Adminpanel::Gallery.destroy_all
      Adminpanel::Gallery.create
      assert_equal 1, Adminpanel::Gallery.first.position

      gallery_2 = Adminpanel::Gallery.new
      gallery_2.save
      assert_equal 2, gallery_2.position

      assert_equal 2, Adminpanel::Gallery.all.count
    end

    def test_destroy_callback

      @gallery_1.destroy
      assert_equal 1, @gallery_2.reload.position
      assert_equal 2, @gallery_3.reload.position

      @gallery_3.destroy
      assert_equal 1, @gallery_2.reload.position

    end

    def test_moving_and_object_to_lower_priority
      # make sure fixtures are as expected
      assert_equal 1, @gallery_1.position
      assert_equal 2, @gallery_2.position
      assert_equal 3, @gallery_3.position

      @gallery_1.move_to_position(3)

      # make sure they are updated from database
      assert_equal 3, @gallery_1.reload.position
      assert_equal 1, @gallery_2.reload.position
      assert_equal 2, @gallery_3.reload.position
    end

    def test_moving_and_object_to_higher_priority
      @gallery_3.move_to_position(1)

      # make sure they are updated from database
      assert_equal 2, @gallery_1.reload.position
      assert_equal 3, @gallery_2.reload.position
      assert_equal 1, @gallery_3.reload.position
    end

    def test_moving_to_same_position
      @gallery_3.move_to_position(3)

      # make sure they are updated from database
      assert_equal 1, @gallery_1.reload.position
      assert_equal 2, @gallery_2.reload.position
      assert_equal 3, @gallery_3.reload.position
    end

    private
      def instance_objects
        @gallery_1 = adminpanel_galleries(:one)
        @gallery_2 = adminpanel_galleries(:two)
        @gallery_3 = adminpanel_galleries(:three)
      end
  end
end
