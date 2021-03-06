require 'test_helper'

class SelectTest < ViewCase

  setup :sign_in
  teardown :teardown

  def test_select_with_active_record_collection
    # test permission, which proc in options gives an
    # activerecord array as a response.

    visit adminpanel.new_permission_path

    select_selector = find('#permission_role_id')

    assert select_selector.find('option', text: 'Admin')
    assert select_selector.find('option', text: 'Superuser')
    assert select_selector.find('option', text: 'Deleter')
    assert select_selector.find('option', text: 'Reader')
    assert select_selector.find('option', text: 'Updater')
    assert select_selector.find('option', text: 'Creator')
    assert select_selector.find('option', text: 'Publisher')
  end

  def test_select_with_diffent_name_method
    # test select, with a name method different than the default
    visit adminpanel.new_salesman_path
    # puts page.
    select_field = find('#salesman_product_id')
    assert select_field
    assert select_field.find('option', text: adminpanel_products(:first).supername)
    assert select_field.find('option', text: adminpanel_products(:limit_images).supername)
  end

  def test_select_with_multiple_option_should_create_select2
    visit adminpanel.new_category_path
    assert has_selector?('select[data-adminpanel-select2][multiple]', visible: false)
    assert has_selector?('span.select2')

  end

  def test_select_with_grouped_should_render_optgroup
    visit adminpanel.new_category_path

    select_field = find('select[data-adminpanel-select2][multiple]', visible: false)

    assert select_field
    assert select_field.has_selector?('optgroup', visible: false)
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
