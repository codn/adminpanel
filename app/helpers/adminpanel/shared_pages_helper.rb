module Adminpanel
  module SharedPagesHelper
    ### Searches for current controller's Class (@model) associaciations
    # and execute the association method on the model, It's going
    # to return 'name' of the related object if it exists.
    # E.x. Given a Prodcuct that belongs_to category, this method
    # is going to search for a relationship named 'category'
    def belong_to_object_name(resource, belongs_to_assoc_name)
      if !resource.send(belongs_to_assoc_name).nil? #if there's something in the association
        return resource.send(belongs_to_assoc_name).name
      else
        return "#{belongs_to_assoc_name} N/A"
      end
    end

    def pluralize_model(class_name)
      demodulize_class(class_name).pluralize
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
        return 'active'
      else
        return ''
      end
    end

    def get_oauth_link(resource)
      Koala::Facebook::OAuth.new(
        Adminpanel.fb_app_id,
        Adminpanel.fb_app_secret,
        url_for({
          controller: params[:controller],
          action: 'fb_choose_page',
          id: resource,
          host: request.host
        })
      ).url_for_oauth_code
    end

    def field_value(attr_type, attribute, object)
      case attr_type
      when 'select'
        belong_to_object_name(object, attribute.gsub('_id', ''))
      when 'checkbox'
        li_tags = ""
        content_tag :ul do
          object.send(attribute.gsub('_ids', '').pluralize).each do |member|
            li_tags << content_tag(:li, class: 'priority-low') do
              member.name
            end
          end
          li_tags.html_safe
        end
      when 'file_field'
        link_to(object.send("#{attribute}_url").split('/').last, object.try(:send, "#{attribute}_url")) if object.send("#{attribute}_url").present?
      when 'image_field'
        content_tag :ul do
          if object.send("#{attribute}_url").present?
            image_tag(object.send("#{attribute}_url", :thumb))
          else
            'N/A'
          end
        end
      when 'boolean'
        if object.send(attribute)
          I18n.t('action.is_true')
        else
          I18n.t('action.is_false')
        end
      when 'enum_field'
        I18n.t("#{object.class.name.demodulize.downcase}.#{object.send(attribute)}")
      when 'adminpanel_file_field'
        object.send(attribute).count
      when 'wysiwyg_field'
        strip_tags(object.send(attribute).to_s).truncate(120)
      else
        object.send(attribute)
      end
    end

    def is_customized_field?(field_name)
      field_name = field_name.to_sym
      [
        :adminpanel_file_field,
        :file_field,
        :non_image_file_field,
        :checkbox,
        :select
      ].include? field_name
    end

    def table_type(model)
      if model.is_sortable?
        'sortable'
      else
        'information-table'
      end
    end
  end
end
