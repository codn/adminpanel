module Adminpanel
	module ApplicationHelper
		def custom_form_for(name, *args, &block)
			options = args.extract_options!
			options.reverse_merge! :builder => CustomFormBuilder, :html => { :class => "form-horizontal" }

			form_for(name, *(args << options), &block)
		end

		def full_title(page_title)
			base_title = "JR Envases"
			if page_title.empty?
				base_title
			else
				"#{page_title} | #{base_title}"
			end
		end

		def is_current_section?(*controller)
			controller.include?(params[:controller]) ? 'active' : nil
		end

		def section_is_login(section_name)
			section_name.downcase == 'login'
		end

		def link_to_add_fields(name, f, association)
			new_object = f.object.send(association).klass.new
			id = new_object.object_id
			fields = f.fields_for(association, new_object, :child_index => id) do |builder|
			  render(association.to_s.singularize + "_fields", :f => builder)
			end
			link_to(content_tag(:div, content_tag(:button, 
						content_tag(:h6, name, :id => "add-estimate-button"),
						 :class => "btn btn-success btn-mini"), :class => "mws-form-row"), 
			'#', :class => "add_fields", :data => {:id => id, :fields => fields.gsub("\n", "")})
		end

		def sign_in(user)
			cookies.permanent[:remember_token] = user.remember_token
			self.current_user = user
		end

		def signed_in?
			!current_user.nil?
		end

		def current_user=(user)
			@current_user = user
		end

		def current_user
			@current_user ||= User.find_by_remember_token(cookies[:remember_token])
		end

		def sign_out
			self.current_user = nil
			cookies.delete(:remember_token)
		end

		def initialize_breadcrumb
			@breadcrumb ||= [:title => 'Inicio', :url => root_url] 
		end

		def breadcrumb_add(title, url)
			initialize_breadcrumb << { :title => title, :url => url }
		end

		def render_breadcrumb(divider)
			render :partial => 'shared/breadcrumb', :locals => { :nav => initialize_breadcrumb, :divider => divider }
		end
	end
end