require 'test_helper'

class DropzoneElementGenerationTest < ViewCase
  fixtures :all

  setup :sign_in

  test "rendering the form should display the dropzone element" do
    visit adminpanel.new_product_path

    assert_selector '#photo_dropzone'
  end

  test "render the form should add a hidden input for each existing photos" do
    product = adminpanel_products(:first)
    visit adminpanel.edit_product_path(product)

    assert_selector '#photo_dropzone'
    assert_selector "input[type='hidden'][name='product[photo_ids][]']", count: product.photos.count
  end

  protected
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
