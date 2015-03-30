require 'test_helper'

class CheckboxTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_checkboxes_with_active_record_collection
    # test permission, which proc in options gives an
    # activerecord array as a response.

    visit adminpanel.new_role_path

    checkbox_container = find('#permission-relation')

    assert checkbox_container.find('label > label', text: 'Publisher: ')
    assert checkbox_container.find('label > label', text: 'Creator: ')
    assert checkbox_container.find('label > label', text: 'Updater: ')
    assert checkbox_container.find('label > label', text: 'Reader: ')
    assert checkbox_container.find('label > label', text: 'Deleter: ')
  end

  def test_checkboxes_with_mapped_result
    # test select, with proc in options gives an
    # [['one', '1'], ['two', '2'], ...] as a repsonse (map)
    # visit adminpanel.new_salesman_path
    # select_field = find('#salesman_product_id')
    # assert select_field
    # assert select_field.find('option', text: 'SuperProduct saved')
    # assert select_field.find('option', text: 'SuperProduct with limit')
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
