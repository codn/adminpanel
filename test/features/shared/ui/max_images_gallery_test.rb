require 'test_helper'

class MaxImagesGalleryTest < ViewCase
  fixtures :all

  setup :sign_in

  def test_exclution_of_button_when_max_file_is_limit
    # maximum of products is 2.
    visit adminpanel.new_product_path

    assert_selector '#add-image-link'
    click_link 'add-image-link'
    assert_selector '#add-image-link'
    click_link 'add-image-link'
    ## $('#add-image-link') should not be visible if max files is reached
    assert_no_selector '#add-image-link'

    click_button 'Eliminar', match: :first
    ## $('#add-image-link') should be visible again if a file is deleted
    assert_selector '#add-image-link'
  end

  def test_no_button_when_editing_with_max_files
    # maximum of products is 2.
    product = adminpanel_products(:limit_images)
    2.times do |time|
      product.photos.create(file: fixture_file_upload('dog fries.png'))
    end
    visit adminpanel.edit_product_path(product)
    ## $('#add-image-link') should not be visible if max files is reached (it is reached)
    # assert_no_selector '#add-image-link'

    assert_no_selector '#add-image-link'

    click_button 'Eliminar', match: :first
    ## $('#add-image-link') should be visible again if a file is deleted
    assert_selector '#add-image-link'
  end

  def test_add_image_button_must_exist_when_no_max_file
    visit adminpanel.new_file_resource_path
    assert_selector '#add-image-link'
    # assert true
  end

  protected
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
