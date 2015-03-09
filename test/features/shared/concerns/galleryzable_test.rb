require 'test_helper'

class GalleryzableTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_including_chveron_icons
    skip 'TODO: gallery test'
    visit adminpanel.gallery_path(adminpanel_galleries(:one))

    # assert for sortable stuff
    assert_selector 'i.fa.fa-chevron-down'
    assert_selector 'i.fa.fa-chevron-up'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
  end
end
