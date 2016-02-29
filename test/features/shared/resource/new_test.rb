require 'test_helper'

class NewTest < ViewCase

  setup :visit_adminpanel_new_product_path
  teardown :teardown

  def test_shared_new_page_messages
    assert_button(I18n.t('action.add', resource: Adminpanel::Product.display_name))
  end

  def test_submitting_with_invalid_information
    sleep 0.2
    click_button('Agregar Producto')
    assert_content('Producto no pudo guardarse debido a 3 errores')
  end

  def test_submitting_with_valid_information
    fill_in 'product_name', with: 'product name'
    fill_in 'product_price', with: '855.5'


    page.execute_script(
      %Q(
        var editor = $('#description-trix-editor')[0].editor;
        editor.insertString("Que pepsi");
      )
    ) # to fill the wysiwyg editor
    click_button('Agregar Producto')
    assert_content('product name')
    assert_content('855.5')
    saved_product = Adminpanel::Product.last
    assert_equal 'product name', saved_product.name
    assert_equal '855.5', saved_product.price
    assert_equal '<div>Que pepsi</div>', saved_product.description
  end

  protected
  def visit_adminpanel_new_product_path
    visit adminpanel.signin_path
    login
    visit adminpanel.new_product_path
  end
end
