require 'test_helper'

class RouterHelperTest < ActionView::TestCase
  include Adminpanel::RouterHelper

  fixtures :all

  def test_get_gallery_childen
    assert_equal 'photos', get_gallery_children(:products)
  end

  def test_resource_parameters
    assert_equal( { path: 'categorias' }, resources_parameters(:categories) )
    assert_equal( { path: 'articulo-espacios-mayusculas-y-acentos' }, resources_parameters(:items) )
  end

  def test_has_fb_share?
    assert_equal false, has_fb_share?(:categories)
    assert_equal true, has_fb_share?(:products)
  end
end
