module Adminpanel
	module SharedPagesHelper
		def parent_object_name(resource, parent_model)
			@model.reflect_on_all_associations.each do |association|
        if association.klass.to_s == parent_model
        	if !resource.send(association.name).nil?
        		return resource.send(association.name).name
						# return resource.client
        	else
        		return "N/A #{association.klass.to_s}"
        	end
        end
      end
		end

		def pluralize_model(class_name)
			"#{demodulize_class(class_name).pluralize}"
		end

		def relationship_ids(class_string)
			"#{demodulize_class(class_string)}_ids"
		end

		def class_name_downcase(object)
			demodulize_class(object.class)
		end

		def demodulize_class(class_name)
			class_name.to_s.demodulize.downcase
		end

		def active_tab(index)
			if index == 0
				return "active"
			else
				return ""
			end
		end

	end
end
