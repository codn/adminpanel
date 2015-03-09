require 'test_helper'

class SortableTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown
  def test_including_of_position_and_default_icons
    visit adminpanel.galleries_path
    assert_link 'Crear Galeria'

    # test for draggable element
    assert_selector 'td.draggable'

    assert_selector 'i.fa.fa-pencil'
    assert_selector 'i.fa.fa-trash-o'
    assert_selector 'i.fa.fa-search-plus'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
  end
end
