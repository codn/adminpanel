require 'test_helper'
module Adminpanel
  class SortableGalleryUnitTest < ActiveSupport::TestCase
    setup :instance_objects

    def test_has_and_ordered_scope
      gallery = adminpanel_galleries(:one)
      ordered_galleries = gallery.galleryfiles.ordered.pluck(:position)
      assert_equal [1,2,3,4,5], ordered_galleries
    end

    def test_creation_callback
      gallery = adminpanel_galleries(:one)
      assert_equal 5, gallery.galleryfiles.count

      galleryfile = gallery.galleryfiles.new
      galleryfile.save

      assert_equal 6, galleryfile.reload.position
      assert_equal 6, gallery.galleryfiles.count

    end

    def test_destroy_callback
      @fgo_p2.destroy
      assert_equal 1, @fgo_p1.reload.position
      assert_equal 2, @fgo_p3.reload.position
      assert_equal 3, @fgo_p4.reload.position
      assert_equal 4, @fgo_p5.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position

      @fgo_p1.destroy
      assert_equal 1, @fgo_p3.reload.position
      assert_equal 2, @fgo_p4.reload.position
      assert_equal 3, @fgo_p5.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position

      @fgo_p5.destroy
      assert_equal 1, @fgo_p3.reload.position
      assert_equal 2, @fgo_p4.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position
    end

    def test_moving_and_object_to_lower_priority
      # make sure fixtures are as expected
      assert_equal 1, @fgo_p1.position
      assert_equal 2, @fgo_p2.position
      assert_equal 3, @fgo_p3.position
      assert_equal 4, @fgo_p4.position
      assert_equal 5, @fgo_p5.position

      assert_equal 1, @sgo_p1.position
      assert_equal 2, @sgo_p2.position


      @fgo_p2.move_to_position(5)

      # make sure they are updated from database
      assert_equal 1, @fgo_p1.reload.position
      assert_equal 5, @fgo_p2.reload.position
      assert_equal 2, @fgo_p3.reload.position
      assert_equal 3, @fgo_p4.reload.position
      assert_equal 4, @fgo_p5.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position
    end

    def test_moving_and_object_to_higher_priority
      @fgo_p5.move_to_position(1)

      # make sure they are updated from database
      assert_equal 2, @fgo_p1.reload.position
      assert_equal 3, @fgo_p2.reload.position
      assert_equal 4, @fgo_p3.reload.position
      assert_equal 5, @fgo_p4.reload.position
      assert_equal 1, @fgo_p5.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position
    end

    def test_moving_to_same_position
      @fgo_p5.move_to_position(5)

      # make sure they are updated from database
      assert_equal 1, @fgo_p1.reload.position
      assert_equal 2, @fgo_p2.reload.position
      assert_equal 3, @fgo_p3.reload.position
      assert_equal 4, @fgo_p4.reload.position
      assert_equal 5, @fgo_p5.reload.position

      assert_equal 1, @sgo_p1.reload.position
      assert_equal 2, @sgo_p2.reload.position
    end

    private
      def instance_objects
        # fgo => first gallery object
        # sgo => second gallery object (since there are 2 galleries according to fixtures)
        # p1 => means original position 1 and so on...
        @fgo_p1 = adminpanel_galleryfiles(:first)
        @fgo_p2 = adminpanel_galleryfiles(:second)
        @fgo_p3 = adminpanel_galleryfiles(:third)
        @fgo_p4 = adminpanel_galleryfiles(:fourth)
        @fgo_p5 = adminpanel_galleryfiles(:fifth)
        @sgo_p1 = adminpanel_galleryfiles(:first_2)
        @sgo_p2 = adminpanel_galleryfiles(:second_2)
      end
  end
end
