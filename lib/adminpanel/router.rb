module Adminpanel
	class Router
		def self.resources
			debugger
			@controllers ||= self.find_resources
		end

		def self.find_resources
			controllersDirectory = 'app/controllers/adminpanel'
			if File.directory?(controllersDirectory)
				Dir.entries(controllersDirectory).collect do |f|
					filePath = "#{controllersDirectory}/#{f}"
					File.file?(filePath) ? filePath : nil
				end
			end
		end
	end
end