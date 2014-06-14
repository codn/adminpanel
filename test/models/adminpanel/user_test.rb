require 'test_helper'

module Adminpanel
  class UserTest < ActiveSupport::TestCase
    setup :assign_user

    def test_is_valid_user
      assert @test_user.save
    end

    def test_name_validation
      @test_user.name = ""
      assert_not @test_user.valid?
    end

    def test_email_validation
      @test_user.email = "foo@"
      assert_not @test_user.valid?

      @test_user.email = "foo@bar"
      assert_not @test_user.valid?

      @test_user.email = "@bar.baz"
      assert_not @test_user.valid?

      @test_user.email = "foo.baz"
      assert_not @test_user.valid?
    end

    def test_password_validation
      @test_user.password_confirmation = "foobaz"
      assert_not @test_user.valid?

      @test_user.password_confirmation = "foo"
      @test_user.password = "foo"
      assert_not @test_user.valid?
    end

  protected
    def assign_user
      @test_user = Adminpanel::User.new(
        name: "Example User",
        email: "foo@bar.com",
        password: "foobar",
        password_confirmation: "foobar",
        rol_id: adminpanel_rols(:Admin).id
      )
    end

  end
end
