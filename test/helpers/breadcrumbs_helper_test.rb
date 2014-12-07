require 'test_helper'

class BreadrumbsHelperTest < ActionView::TestCase
  include Adminpanel::BreadcrumbsHelper
  include Rails.application.routes.url_helpers

  fixtures :all

  setup :setup
  teardown :teardown

  def setup
    breadcrumb_add('controller', 'http://controller.com')
    breadcrumb_add('action', 'http://action.com')
  end

  def teardown
    @breadcrumb = :nil
  end

  def test_breadcrumb_add
    assert_equal( { title: I18n.t('breadcrumb.index'), url: adminpanel.root_url }, @breadcrumb.first)
    assert_equal( { title: 'controller', url: 'http://controller.com' }, @breadcrumb.second)
    assert_equal( { title: 'action', url: 'http://action.com' }, @breadcrumb.third)
  end

  def test_render_breadcrumb
    assert_equal(
      render_breadcrumb('divider'),
      render(partial: 'adminpanel/shared/breadcrumb', locals: { nav: @breadcrumb, divider: 'divider' })
    )
  end
end
