require 'test_helper'

class FriendlyTest < ViewCase
  fixtures :all

  setup :sign_in
  teardown :teardown

  def test_match_correct_path
    visit adminpanel.product_path(adminpanel_products(:first))

    assert current_url.match('productos/first-product-slug')
  end

  protected

    def sign_in
      visit adminpanel.signin_path
      login
    end
end
