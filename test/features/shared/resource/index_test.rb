require 'test_helper'

class IndexTest < ViewCase
  fixtures :all

  setup :sign_in
  def test_index_buttons_of_resources
    visit adminpanel.salesmen_path
    assert_link 'Crear Agente'
    assert_selector 'i.fa.fa-pencil'
    assert_selector 'i.fa.fa-search-plus'
    assert_selector 'i.fa.fa-facebook'
    assert_selector 'i.fa.fa-twitter'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
  end
end
