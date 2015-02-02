require 'test_helper'
require 'generators/adminpanel/dump/dump_generator'

class DumpGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::DumpGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_user_dump
    assert_no_file( 'db/users.json' )
    assert( Adminpanel::User.count > 0 ) #ensure there's something in adminpanel_users

    run_generator %w(
      user
      -i
      false
    )

    #assert has user fields in json format, in an array dumped
    assert_file(
      'db/users.json',
      /\[{/,
      /}\]/,
      /"name":"Example User"/,
      /"email":"user@example.com"/,
      /"role_id":/
    )
  end

  def test_runs_without_errors
    Dir.mkdir("#{Rails.root.join('tmp/generators')}/db")
    File.open("#{Rails.root.join('tmp/generators')}/db/seeds.rb", 'w') do
      "\n"
    end
    assert_nothing_raised do
      run_generator ['user']
    end
  end
end
