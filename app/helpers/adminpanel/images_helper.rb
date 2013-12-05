module Adminpanel
	module ImagesHelper

		def is_class?(name)
			Module.const_get(name).is_a?(Class) 
			rescue NameError 
				return false
		end
	end
end