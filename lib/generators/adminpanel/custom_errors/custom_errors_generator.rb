require 'rails/generators/active_record'

module Adminpanel
  class CustomErrorsGenerator < ActiveRecord::Generators::Base
    desc 'Generate ErrorsController, template and configure the app to show our errors'
    source_root File.expand_path('../templates', __FILE__)
    argument :name, type: :string, default: 'default', require: false

    def copy_errors_controller
      copy_file 'errors_controller.rb', 'app/controllers/errors_controller.rb'
    end

    def copy_errors_template
      copy_file 'show.html.erb', 'app/views/errors/show.html.erb'
    end

    def inject_errors_into_routes
      inject_into_file 'config/routes.rb', before: "\nend\n" do
        "\n  get \"(errors)/:status\", to: \"errors#show\", constraints: { status: /\d{3}/ }"
      end
    end

    def inject_error_handling_app_in_configuration
      inject_into_file 'config/application.rb', after: 'class Application < Rails::Application' do
        "\n    config.exceptions_app = -> (env) { ErrorsController.action(:show).call(env) }"
      end
    end

    def print_messages
      puts "The generator tried it's best to insert into config/routes.rb"
      puts '  get "(errors)/:status", to: "errors#show", constraints: { status: /\d{3}/ }'
      puts 'and into config/application.rb'
      puts '  config.exceptions_app = -> (env) { ErrorsController.action(:show).call(env) }'
      puts 'Make sure those lines are actually there. You can customize your messages in app/controllers/errors_controller.rb and in app/views/errors/show.html.erb'
    end
  end
end
