module Adminpanel
    class Router
        def self.adminpanel_resources
            @files ||= find_resources
        end

        def self.find_resources
            resources_path = "#{Rails.root.to_s}/app/controllers/"
            if File.directory?(resources_path)
                files = Dir.entries(resources_path).collect do |f|
                    if f != "application_controller.rb"
                        file_path = "#{resources_path}#{f}"
                        File.file?(file_path) ? file_path.sub!(resources_path, '').sub!('_controller.rb', '') : nil
                    end
                end

                files.compact!
            else
                nil
            end
        end

        def self.menu_items
            @menu ||= adminpanel_resources.each.collect { |resource| resource.classify }
        end
    end
end