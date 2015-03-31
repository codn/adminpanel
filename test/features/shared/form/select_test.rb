require 'test_helper'

class SelectTest < ViewCase
  fixtures :all

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

  def test_select_with_mapped_result
    # test select, with proc in options gives an
    # [['one', '1'], ['two', '2'], ...] as a repsonse (map)
    visit adminpanel.new_salesman_path
    # puts page.
    select_field = find('#salesman_product_id')
    assert select_field
    assert select_field.find('option', text: 'SuperProduct saved')
    assert select_field.find('option', text: 'SuperProduct with limit')
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
