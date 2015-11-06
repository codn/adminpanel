require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'

class BelongsToRemoteTest < ViewCase

  setup :visit_adminpanel_new_salesman_path
  teardown :teardown

  def test_add_remote_product_link_exist
    assert_link('Agregar Producto')
  end

  def test_adding_a_remote_product_with_invalid_information
    trigger_modal 'Agregar Producto'
    assert_equal 'Agregar Producto', find('#modal-title').text
    submit_modal 'Agregar Producto'
    assert_content( I18n.t('errors', model: 'Producto', count: 3) )
  end

  def test_adding_a_remote_product_with_valid_information
    trigger_modal 'Agregar Producto'
    fill_in 'product_name', with: 'remote product'
    fill_in 'product_description', with: 'remote description lorem'
    fill_in 'product_price', with: '12.3'
    submit_modal 'Agregar Producto'

    assert_xpath("//option[contains(text(), 'remote product' )]")
  end

  private

  def visit_adminpanel_new_salesman_path
    visit adminpanel.signin_path
    login
    visit adminpanel.new_salesman_path
  end
end
