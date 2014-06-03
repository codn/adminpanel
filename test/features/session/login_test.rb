require 'test_helper'

class LoginTest < ViewCase
  fixtures :all

  setup :visiting_signin

  def test_login_messages
    assert_content I18n.t('authentication.welcome')
  end

  def test_logging_in_with_valid_information
    login
    assert_content I18n.t('authentication.signin_success')
    assert_content I18n.t('authentication.logout')
    signout
    assert_content I18n.t('authentication.welcome')
  end

  def test_logging_in_with_invalid_information
    login('foobaz') #pass is foobar
    assert_content I18n.t('authentication.signin_error')
  end

  protected
  def visiting_signin
    visit adminpanel.signin_path
  end

  def signout
    click_link 'signout-button'
  end
end
