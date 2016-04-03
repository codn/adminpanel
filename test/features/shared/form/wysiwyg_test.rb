require 'test_helper'

class WysiwygTest < ViewCase

  setup :sign_in
  teardown :teardown

  def test_form_with_trix_data_attributes_when_uploader
    visit adminpanel.new_test_object_path

    assert_equal '/adminpanel/please-overwrite-self-display_names/agregar-a-galeria', find('form')['data-trix-url'], "data-trix-url not correct"
    assert_equal 'Adminpanel::TestObject', find('form')['data-parent-class'], "data-parent-class not correct"
    assert_equal 'test_object', find('form')['data-params-key'], "data-params-key not correct"

    assert_selector 'input[name="test_object[textfile_ids][]"]'
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
