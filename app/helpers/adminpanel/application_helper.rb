module Adminpanel
	module ApplicationHelper
		include SessionsHelper
		include BreadcrumbsHelper
		include SharedPagesHelper
		include PluralizationsHelper

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

		def is_current_section?(display_name)
			display_name == params[:controller].classify.constantize.display_name ? 'active' : nil
		end

		def section_is_login(section_name)
			section_name.downcase == 'login'
		end

		def link_to_add_fields(name, f, association)
			new_object = f.object.send(association).klass.new
			id = new_object.object_id
			fields = f.fields_for(association, new_object, :child_index => id) do |builder|
			  render("shared/image_fields", :f => builder)
			end
			link_to(content_tag(:div, content_tag(:button,
						content_tag(:h6, name, :id => "add-image-button"),
						 :class => "btn btn-success btn-mini"), :class => "mws-form-row"),
			'#', :class => "add_fields", :data => {:id => id, :fields => fields.gsub("\n", "")})
		end

		def route_symbol(model_name)
			model_name.pluralize.downcase
		end

		def symbol_class(symbol)
			"adminpanel/#{symbol.to_s}".classify.constantize
		end

		def main_root_path
			if main_app.respond_to?(root_path)
				main_app.root_path
			else
				"/"
			end
		end
	end
end
