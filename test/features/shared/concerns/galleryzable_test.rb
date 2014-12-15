require 'test_helper'

class GalleryzableTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_including_chveron_icons
    visit adminpanel.galleries_path(adminpanel_galleries(:one))

    # if this 2 icons exists, routes exist too
    assert_selector 'i.fa.fa-chevron-down'
    assert_selector 'i.fa.fa-chevron-up'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
  end
end
