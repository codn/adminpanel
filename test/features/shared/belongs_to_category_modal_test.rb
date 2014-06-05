require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'

class BelongsToCategoryModalTest < ViewCase

  setup :visit_adminpanel_new_department_path
  teardown :teardown

  def test_add_remote_category_link_exist
    assert_link('Agregar Categoria')
  end

  def test_adding_a_remote_category_with_invalid_information
    trigger_modal 'Agregar Categoria'
    assert_equal 'Agregar Categoria', find('#modal-title').text
    submit_modal 'Agregar Categoria'
    assert_content( I18n.t('errors', model: 'Categoria', count: 1) )
  end

  def test_adding_a_remote_category_with_valid_information
    trigger_modal 'Agregar Categoria'
    fill_in 'category_name', with: 'remote product'
    submit_modal 'Agregar Categoria'
    assert_xpath("//option[contains(text(), 'remote product' )]")
  end

  private

  def visit_adminpanel_new_department_path
    visit adminpanel.signin_path
    login
    visit adminpanel.new_department_path
  end
end
