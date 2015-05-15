require 'test_helper'

class SortableGalleryUiTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_including_draggable_td
    visit adminpanel.gallery_path(adminpanel_galleries(:one))

    # assert for sortable stuff
    assert_selector 'td.draggable.img'
  end

  protected

    def sign_in
      visit adminpanel.signin_path
      login
    end
end
