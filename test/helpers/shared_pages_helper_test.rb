require 'test_helper'

class SharedPagesHelperTest < ActionView::TestCase
  include Adminpanel::SharedPagesHelper
  fixtures :all

  def test_belong_to_object_name
    @model = Adminpanel::Salesman
    #according to fixtures and dummy app relationships
    assert_equal 'Product saved', belong_to_object_name(adminpanel_salesmen(:one), 'product')
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

  def test_string_in_field_value
    test_object = adminpanel_test_objects(:first)
    attribute = 'name'
    properties = {
      'type' => 'text_field',
      'label' => 'name'
    }
    assert_equal(
      'John Doe',
      field_value(
        properties,
        attribute,
        test_object
      ),
      'didn\'t matched :('
    )
  end

  def test_boolean_in_field_value
    test_object = adminpanel_test_objects(:first)
    attribute = 'boolean'
    properties = {
      'type' => 'boolean',
      'label' => 'boolean'
    }
    assert_equal(
      I18n.t('action.is_true'),
      field_value(
        properties,
        attribute,
        test_object
      ),
      'didn\'t matched boolean :('
    )
  end

  def test_belongs_to_in_field_value
    @model = Adminpanel::Salesman # simulating salesman controller
    test_object = adminpanel_salesmen(:one)
    attribute = 'product_id'
    properties = {
      'type' => 'belongs_to',
      'model' => 'Adminpanel::Product',
      'label' => 'product',
    }
    assert_equal(
      'Product saved',
      field_value(
        properties,
        attribute,
        test_object
      ),
      'didn\'t matched belongs_to :('
    )
  end

  def test_has_many_in_field_value
    test_object = adminpanel_test_objects(:first)
    attribute = 'category_ids'
    properties = {
      'type' => 'has_many',
      'model' => 'Adminpanel::Category',
      'label' => 'hasmany'
    }
    # puts test_object.categories.inspect
    assert_equal(
      content_tag(:ul, nil) do
        content_tag(:li, nil, class: 'priority-low') do
          adminpanel_categories(:nice).name
        end +
        content_tag(:li, nil, class: 'priority-low') do
          adminpanel_categories(:pretty).name
        end
      end,
      field_value(
        properties,
        attribute,
        test_object
      ),
      'didn\'t matched has_many fields :('
    )
  end

  def test_file_field_in_field_value
    test_object = adminpanel_galleries(:one)
    attribute = 'file'
    properties = {
      'type' => 'file_field',
      'label' => 'file'
    }
    assert_equal(
      content_tag(:ul) do
        image_tag(
          test_object.send(
            "#{attribute}_url",
            :thumb
          )
        )
      end,
      field_value(
        properties,
        attribute,
        test_object
      ),
      'regex didn\'t matched :('
    )
  end

  def test_is_customized_field?
    assert_equal true, is_customized_field?('adminpanel_file_field')
    assert_equal true, is_customized_field?('belongs_to')
    assert_equal true, is_customized_field?('file_field')
    assert_equal true, is_customized_field?('has_many')
    assert_equal true, is_customized_field?('has_many')
    # some example false values (not everyone)
    assert_equal false, is_customized_field?('text_field')
    assert_equal false, is_customized_field?('number_field')
    assert_equal false, is_customized_field?('text_area')
    assert_equal false, is_customized_field?('wysiwyg_field')
  end

end
