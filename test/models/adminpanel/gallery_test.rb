require 'test_helper'
module Adminpanel
  class GalleryTest < ActiveSupport::TestCase

    def test_moving_up_with_the_best_position
      gallery_1 = adminpanel_galleries(:one)
      gallery_1.move_to_better_position
      assert_equal 1, gallery_1.position
    end

    def test_moving_down_with_the_worst_position
      gallery_3 = adminpanel_galleries(:three)
      gallery_3.move_to_worst_position
      assert_equal 3, gallery_3.position
    end

    def test_moving_up_with_intermediate_position
      gallery_2 = adminpanel_galleries(:two)
      gallery_2.move_to_better_position
      assert_equal 1, gallery_2.position
    end

    def test_moving_down_with_intermediate_position
      gallery_2 = adminpanel_galleries(:two)
      gallery_2.move_to_worst_position
      assert_equal 3, gallery_2.position
    end

    def test_file_presence
      g = Adminpanel::Gallery.new
      assert_not g.save
    end

  end
end
