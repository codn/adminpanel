require 'test_helper'

class ShowTest < ViewCase
  fixtures :all

  setup :sign_in
  def test_resource_contenets_and_links
    assert_content(adminpanel_products(:first).name)
    assert_content(adminpanel_products(:first).price)
    assert_content(adminpanel_products(:first).description)
    assert_selector 'i.fa.fa-pencil'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
    visit adminpanel.product_path( adminpanel_products(:first) )
  end
end
