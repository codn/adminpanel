module Adminpanel
	module ApplicationHelper
		include SessionsHelper
		include BreadcrumbsHelper
		include SharedPagesHelper

		def custom_form_for(name, *args, &block)
			options = args.extract_options!
			options.reverse_merge! :builder => Adminpanel::CustomFormBuilder, :html => { :class => "form-horizontal" }

			form_for(name, *(args << options), &block)
		end

		def full_title(page_title)
			base_title = t("Panel title")
			if page_title.empty?
				base_title
			else
				"#{page_title} | #{base_title}"
			end
		end

		def is_current_section?(controller_name)
			"adminpanel/#{controller_name.downcase.pluralize}".include?(params[:controller]) ? 'active' : nil
		end

		def section_is_login(section_name)
			section_name.downcase == 'login'
		end

		def link_to_add_fields(name, f, association, model_name)
			new_object = f.object.send(association).klass.new
			id = new_object.object_id
			fields = f.fields_for(association, new_object, :child_index => id) do |builder|
			  render("shared/" + association.to_s.singularize + "_fields", :f => builder, :model_name => model_name)
			end
			link_to(content_tag(:div, content_tag(:button,
						content_tag(:h6, name, :id => "add-image-button"),
						 :class => "btn btn-success btn-mini"), :class => "mws-form-row"),
			'#', :class => "add_fields", :data => {:id => id, :fields => fields.gsub("\n", "")})
		end

		def route_symbol(model_name)
			model_name.downcase.pluralize.downcase
		end
	end
end