require 'test_helper'

class NewTest < ViewCase

  setup :visit_new_product
  # teardown :teardown

  def test_shared_new_page_messages
    assert_button("#{I18n.t('action.add')} #{Adminpanel::Product.display_name}")
  end

  def test_submitting_with_invalid_information
    click_button('Agregar Producto')
    assert_content('Producto no pudo guardarse debido a 3 errores')
  end

  def test_submitting_with_valid_information
    fill_in 'product_name', :with => 'product name'
    fill_in 'product_price', :with => '855.5'
    page.execute_script(
      %Q(
        $('#product_description').data('wysihtml5').editor.setValue('que pepsi');
      )
    ) # to fill the wysiwyg editor
    click_button('Agregar Producto')
    assert_content(I18n.t('action.save_success'))
    assert_equal 'product name', Adminpanel::Product.last.name
  end

  protected
  def visit_new_product
    visit adminpanel.signin_path
    login
    visit adminpanel.new_product_path
  end
end
