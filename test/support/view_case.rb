class ViewCase < ActionView::TestCase
  include Capybara::DSL
  include Capybara::Assertions
  include Rails.application.routes.url_helpers

  def teardown
    Capybara.reset_session!
    Capybara.current_driver = :poltergeist
  end

  private
    def login(password = 'foobar')
      fill_in 'inputEmail', with: adminpanel_users(:valid).email
      fill_in 'inputPassword', with: password #pass is foobar
      click_button I18n.t('authentication.new-session')
    end

    def login_user_with_role(role)
      fill_in 'inputEmail', with: adminpanel_users(role).email
      fill_in 'inputPassword', with: 'foobar' #pass is foobar
      click_button I18n.t('authentication.new-session')
    end

    def submit_modal(button)
      click_button button #the modal submit is a button actually, not a link
      sleep 1
    end

    def trigger_modal(link)
      click_link link
      sleep 1
    end
end
