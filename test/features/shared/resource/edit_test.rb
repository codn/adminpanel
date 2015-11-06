require 'test_helper'

class EditTest < ViewCase
  fixtures :all

  setup :visit_adminpanel_new_product_path
  teardown :teardown

  def test_submitting_with_same_information
    assert_button("Actualizar #{adminpanel_products(:first).name}")
    click_button("Actualizar #{adminpanel_products(:first).name}")
    # p page.body
    p adminpanel_products(:first)
    assert_content( adminpanel_products(:first).name )
    assert_content( adminpanel_products(:first).price )
  end

  def test_submitting_with_invalid_information
    fill_in 'product_name', with: ''
    fill_in 'product_price', with: ''
    click_button("Actualizar #{adminpanel_products(:first).name}")
    assert_content('Producto no pudo guardarse debido a 2 errores')
  end

  protected
  def visit_adminpanel_new_product_path
    visit adminpanel.signin_path
    login
    visit adminpanel.edit_product_path(adminpanel_products(:first))
  end
end
