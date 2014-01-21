module Adminpanel
    class Router
        def self.adminpanel_resources
            @files ||= find_resources
        end

        def self.find_resources
            resources_path = "#{Rails.root.to_s}/app/adminpanel/"
            if File.directory?(resources_path)
                files = Dir.entries(resources_path).collect do |f|
                    file_path = "#{resources_path}#{f}"
                    File.file?(file_path) ? file_path.sub!(resources_path, '') : nil
                end
            end
        end
    end
end