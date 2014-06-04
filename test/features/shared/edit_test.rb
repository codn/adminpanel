require 'test_helper'

class EditTest < ViewCase
  fixtures :all

  setup :visit_adminpanel_new_product_path
  teardown :teardown

  def test_shared_new_page_messages
    assert_button('Guardar Producto')
  end

  def test_submitting_with_same_information
    click_button('Guardar Producto')
    sleep 1
    assert_content( I18n.t('action.save_success') )
  end

  def test_submitting_with_invalid_information
    fill_in 'product_name', :with => ''
    fill_in 'product_price', :with => ''
    click_button('Guardar Producto')
    sleep 1
    assert_content('Producto no pudo guardarse debido a 2 errores')
    saved_product = Adminpanel::Product.last
  end

  protected
  def visit_adminpanel_new_product_path
    visit adminpanel.signin_path
    login
    visit adminpanel.edit_product_path(adminpanel_products(:first))
  end
end
