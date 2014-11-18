require 'test_helper'
require 'rails'

class AdminpanelRakeTest < ActiveSupport::TestCase
  include Rake
  include
  Rake.application.rake_require 'tasks/adminpanel/adminpanel'
  Rake::Task.define_task(:environment)

  def test_populate_task
    I18n.enforce_available_locales = false
    I18n.reload!
    products_count = Adminpanel::Product.count
    Rake.application.invoke_task "adminpanel:populate[10, product, name:name description:lorem price:number]"
    assert_equal products_count + 10, Adminpanel::Product.count
    # assert true
  end

  def test_section_task
    Rake.application.invoke_task "adminpanel:section[Mission Mars, about us]"
    last_section = Adminpanel::Section.last
    assert_equal 'Mission Mars', last_section.name
    assert_equal 'About us', last_section.page
    assert_equal 'mission_mars', last_section.key
    assert_equal false, last_section.has_description
    assert_equal false, last_section.has_image
  end

  def test_user_task
    Rake.application.invoke_task 'adminpanel:user'
    generated_user = Adminpanel::User.last
    assert_equal 'webmaster@codn.com', generated_user.email
    assert_equal 'Webmaster', generated_user.name
    assert_equal 'Admin', generated_user.role.name
  end

  def test_dump_task
    ensure_theres_no_dump
    assert( !File.exist?("#{Rails.root}/db/users.json") )
    assert( Adminpanel::User.count > 0 ) #ensure there's something in adminpanel_users

    Rake.application.invoke_task 'adminpanel:dump[user]'
    assert( File.exist?("#{Rails.root}/db/users.json") )
    assert_file( "#{Rails.root}/db/users.json" )
    # assert_content()
  end

  private
    def ensure_theres_no_dump
      if File.exist?("#{Rails.root}/db/users.json")
        File.delete("#{Rails.root}/db/users.json")
      end
    end

end
