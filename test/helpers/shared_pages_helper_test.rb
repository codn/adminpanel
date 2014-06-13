require 'test_helper'

class SharedPagesHelperTest < ActionView::TestCase
  include Adminpanel::SharedPagesHelper
  fixtures :all

  def test_belong_to_object_name
    @model = Adminpanel::Salesman
    #according to fixtures and dummy app relationships
    assert_equal 'Product saved', belong_to_object_name(adminpanel_salesmen(:one), 'Adminpanel::Product')
    @model = nil
  end

  def test_pluralize_model
    assert_equal 'clients', pluralize_model('Adminpanel::Client')
  end

  def test_relaitionship_ids
    assert_equal 'client_ids', relationship_ids('Adminpanel::Client')
  end

  def test_class_name_downcase
    assert_equal 'category', class_name_downcase(Adminpanel::Category.new)
  end

  def test_demodulize_class
    assert_equal 'product', demodulize_class('Adminpanel::Product')
  end

  def test_active_tab
    assert_equal 'active', active_tab(0)
    assert_equal '', active_tab([*1..15].sample)
  end

end
