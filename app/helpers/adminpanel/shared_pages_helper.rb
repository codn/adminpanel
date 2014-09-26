module Adminpanel
  module SharedPagesHelper
    def belong_to_object_name(resource, belong_to_assoc_name)
      @model.reflect_on_all_associations.each do |association|
        if association.name.to_s == belong_to_assoc_name.to_s
          if !resource.send(association.name.to_s).nil? #if there's something in the association
            return resource.send(association.name).name
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

    def property_value properties, attribute
      case properties['type']
      when 'wysiwyg_field'
        @resource_instance.send(attribute)
      when 'belongs_to'
        belong_to_object_name(@resource_instance, attribute.split('_id').first)
      when 'has_many'
        logger.info "hasmany"
        content_tag :ul do
          @resource_instance.send("#{pluralize_model(properties['model'])}").each do |member|
            content_tag :li, class: 'priority-low' do
              member.name
            end
          end
        end
      when 'file_field'
        content_tag :ul do
          image_tag(@resource_instance.send("#{attribute}_url", :thumb))
        end
      when 'boolean'
        content_tag :td do
          if @resource_instance.send(attribute)
            I18n.t('action.is_true')
          else
            I18n.t('action.is_false')
          end
        end
      else
        @resource_instance.send(attribute)
      end
    end

  end
end
