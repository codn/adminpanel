module Adminpanel
  module RouterHelper
    def adminpanel_resources
      @files ||= find_resources
    end

    def find_resources
      resources_path
      if File.directory?(resources_path)
        files = Dir.entries(resources_path).collect do |f|
          unless default_controllers.include?(f)
            file_path = "#{resources_path}#{f}"
            File.file?(file_path) ? file_path.sub!(resources_path, '').sub!('_controller.rb', '') : nil
          end
        end

        files.compact!
      end
    end

    def menu_items
      @menu ||= adminpanel_resources.each.collect { |resource| resource.classify }
    end

    def default_controllers
      ["application_controller.rb", "sessions_controller.rb", "galleries_controller.rb", "users_controller.rb", "sections_controller.rb", "pages_controller.rb"]
    end

    def resources_path
      route = "#{Rails.root.to_s}/app/controllers/adminpanel/"
      if !File.directory?(route)
        Dir.mkdir(route)
      end
      route
    end
  end
end
