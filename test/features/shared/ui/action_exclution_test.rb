require 'test_helper'

class ActionExclutionTest < ViewCase
  fixtures :all

  setup :sign_in
  def test_mugs_index_excluding_every_action_but_index
    visit adminpanel.mugs_path
    assert_no_link 'Crear Taza'
    assert_no_selector 'i.fa.fa-pencil'
    assert_no_selector 'i.fa.fa-search-plus'
    assert_no_selector 'i.fa.fa-facebook'
    assert_no_selector 'i.fa.fa-twitter'
  end

  protected
  def sign_in
    visit adminpanel.signin_path
    login
  end
end
