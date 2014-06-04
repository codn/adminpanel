require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'

class HasManyThroughCategoryModalTest < ViewCase

  setup :visit_adminpanel_new_product_path
  teardown :teardown

  def test_add_remote_product_link_exist
    assert_link('Agregar Categoria')
  end

  def test_adding_a_remote_product_with_invalid_information
    trigger_modal
    sleep 1
    assert_equal  'Agregar Categoria', find('#modal-title').text
    submit_modal
    sleep 1
    assert_content( I18n.t('errors', model: 'Categoria', count: 1) )
  end

  def test_adding_a_remote_product_with_valid_information
    trigger_modal
    fill_in 'category_name', with: 'remote option of category'
    submit_modal
    sleep 1
    assert_content('remote option of category')
  end

  protected

  def submit_modal
    click_button 'Agregar Categoria' #the modal is the button
  end

  def trigger_modal
    click_link 'Agregar Categoria'
  end

  def visit_adminpanel_new_product_path
    visit adminpanel.signin_path
    login
    visit adminpanel.new_product_path
  end
end
