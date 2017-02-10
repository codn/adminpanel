require 'test_helper'

class SortableGalleryUiTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_including_draggable_td
    visit adminpanel.gallery_path(adminpanel_galleries(:one))

    # assert for sortable stuff
    assert adminpanel_galleries(:one).galleryfiles.count > 0
    assert_selector 'td.draggable.img', count: adminpanel_galleries(:one).galleryfiles.count
  end

  protected

    def sign_in
      visit adminpanel.signin_path
      login
    end
end
