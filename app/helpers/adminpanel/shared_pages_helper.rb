module Adminpanel
	module SharedPagesHelper
		def parent_object_name(resource, parent_model)
			@model.reflect_on_all_associations.each do |association|
                if association.klass.to_s == parent_model 
                	if !resource.send(association.name).nil?
                		return resource.send(association.name).name 
                	else
                		return "N/A"
                	end
	            end
	        end
		end
	end
end