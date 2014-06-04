require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'

class BelongsToNonCategoryModalTest < ViewCase

  setup :visit_adminpanel_new_salesman_path
  teardown :teardown

  def test_add_remote_product_link_exist
    assert_link('Agregar Producto')
  end

  def test_adding_a_remote_product_with_invalid_information
    trigger_modal
    assert_equal  'Agregar Producto', find('#modal-title').text
    submit_modal
    assert_content( I18n.t('errors', model: 'Producto', count: 3) )
  end

  def test_adding_a_remote_product_with_valid_information
    trigger_modal
    fill_in 'product_name', with: 'remote product'
    fill_in 'product_description', with: 'remote description lorem'
    fill_in 'product_price', with: '12.3'
    submit_modal
    sleep 1
    # remote_product = Adminpanel::Product.last
    # assert_equal 'remote_product', remote_product.name
    # assert_equal 'remote descrpition lorem', remote_product.description
    # assert_equal '12.3', remote_product.price
    assert_xpath("//option[contains(text(), 'remote product' )]")
  end

  protected

  def submit_modal
    click_button 'Agregar Producto' #the modal is the button
  end

  def trigger_modal
    click_link 'Agregar Producto'
  end

  def visit_adminpanel_new_salesman_path
    visit adminpanel.signin_path
    login
    visit adminpanel.new_salesman_path
  end
end
