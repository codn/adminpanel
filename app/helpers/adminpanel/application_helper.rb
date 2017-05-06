module Adminpanel
  module ApplicationHelper
    include SessionsHelper
    include BreadcrumbsHelper
    include SharedPagesHelper

    def adminpanel_form_for(object, *args, &block)
      options = args.extract_options!
      options.reverse_merge! builder: Adminpanel::AdminpanelFormBuilder, html: { class: 'form-horizontal' }
      if @model.has_gallery?
        options[:html][:"data-parent-object-class"] = @model.to_s
        options[:html][:"data-parent-object-id"] = object.id
        options[:html][:"data-dropzone"] = @model.to_s.demodulize.underscore
        options[:html][:"data-dropzone-galleries"] = @model.galleries.to_json
        if @resource_instance.is_a? Adminpanel::Page
          options[:html][:"data-dropzone-url"] = url_for(controller: :pages, action: :add_to_gallery)
          options[:html][:"data-dropzone-delete-url"] = url_for(controller: :pages, action: :remove_image)
        else
          options[:html][:"data-dropzone-url"] = url_for(controller: @model.to_controller_name, action: :add_to_gallery)
          options[:html][:"data-dropzone-delete-url"] = url_for(controller: @model.to_controller_name, action: :remove_image)
        end
      end
      if @model.has_trix_gallery?
        options[:html][:"data-trix-url"] = url_for(controller: @model.to_controller_name, action: :add_to_gallery)
        options[:html][:"data-parent-class"] ||= @model.to_s
        options[:html][:"data-params-key"] ||= @model.to_s.demodulize.underscore
      end
      if @resource_instance.is_a? Adminpanel::Page
        options[:url] = adminpanel.page_path(@resource_instance)
      end

      form_for(object, *(args << options), &block)
    end

    def full_title(page_title)
      base_title = I18n.t("panel-title")
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
    end

    def is_current_section?(display_name)
      display_name == params[:controller].classify.constantize.display_name ? 'active' : nil
    end

    def link_to_add_fields(name, f, association, hidden='not-hidden')
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render('adminpanel/shared/image_fields', f: builder)
      end
      add_another_image_button = content_tag(:div, id: 'new-image-button') do
        content_tag(:button, class: 'btn btn-success btn-mini') do
          content_tag(:h6, name)
        end
      end
      link_to(
        add_another_image_button,
        '#',
        class: "add-fields #{hidden}",
        id: 'add-image-link',
        data: {
          id: id,
          fields: fields.gsub("\n", "")
        }
      )
    end

    def route_symbol(model_name)
      model_name.pluralize.downcase
    end

    def symbol_class(symbol_model)
      "adminpanel/#{symbol_model.to_s.singularize}".classify.constantize
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
