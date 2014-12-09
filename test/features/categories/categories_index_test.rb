require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'
require 'adminpanel/test_object'

class CategoriesIndexTest < ViewCase
  setup :visit_adminpanel_categories_path
  teardown :teardown

  def test_adding_invalid_category
    assert_link('Crear Categoria para test_object')
    trigger_modal('Crear Categoria para test_object')
    assert_equal('Crear Categoría', find('#myModalLabel').text)
    submit_modal 'Agregar Categoria'
    assert_content( I18n.t('errors', model: 'Categoria', count: 1) )
  end

  def test_adding_valid_category
    trigger_modal('Crear Categoria para test_object')
    fill_in 'category_name', with: 'categories index name'
    submit_modal 'Agregar Categoria'
    assert_xpath("//a[contains(text(), 'categories index name' )]")
  end

  private
    def visit_adminpanel_categories_path
      visit adminpanel.signin_path
      login
      visit adminpanel.categories_path
    end
end
