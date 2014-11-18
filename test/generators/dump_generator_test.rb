require 'test_helper'
require 'generators/adminpanel/dump/dump_generator'

class DumpGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::DumpGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_user_dump
    assert_no_file( 'db/users.json' )
    assert( Adminpanel::User.count > 0 ) #ensure there's something in adminpanel_users

    run_generator %w(user -i false)

    #assert has user fields in json format, in an array.
    assert_file(
      'db/users.json',
      /\[{/,
      /}\]/,
      /"name": "Example User"/,
      /"email": "user@example.com"/,
      /"role_id": /
    )
    assert_file(
      'db/seeds.rb',
      "objects = JSON.parse(open(\"\#{Rails.root}/db/users.json\").read)
      objects.each do |element|
        Adminpanel::User.create element
      end"
    )
  end

  # def test_runs_without_errors
  #   assert_nothing_raised do
  #     run_generator ['user']
  #   end
  # end
end
