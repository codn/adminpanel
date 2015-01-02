require 'test_helper'

class CollectionNameTest < ViewCase
  fixtures :all

  setup :sign_in

  def test_collection_name_overwritten
    visit adminpanel.mugs_path
    assert_link 'Irregular Tazas'
  end

  protected
    def sign_in
      visit adminpanel.signin_path
      login
    end

end
