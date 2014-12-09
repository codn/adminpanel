require 'test_helper'
require 'adminpanel/product'
require 'adminpanel/category'
require 'adminpanel/test_object'

class CategoriesIndexTest < ViewCase
  setup :visit_adminpanel_categories_path
  teardown :teardown

  def test_add_category
    skip
    ### p page.body
    ### :(
    assert_link('Crear Categoria para objeto')
  end

  private
    def visit_adminpanel_categories_path
      visit adminpanel.signin_path
      login
      visit adminpanel.categories_path
    end
end
