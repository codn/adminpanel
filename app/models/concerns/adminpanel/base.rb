module Adminpanel
  module Base
    extend ActiveSupport::Concern

    # static(class) methods
    module ClassMethods
      def mount_images(relation)
        has_many relation, dependent: :destroy
        accepts_nested_attributes_for relation, allow_destroy: true
      end

      # implementing cache by default.
      def belongs_to(name, scope = nil, options = {})
        super(name, scope, options.reverse_merge!({touch: true}))
      end

      def form_attributes
        []
      end

      # The name that is going to be shown in the new button and that is going
      # to be pluralized (if not overwritten) to generate collection_name
      def display_name
        'please overwrite self.display_name'
      end

      # The word that is going to be shown in the side menu, routes and
      # breadcrumb.
      def collection_name
        display_name.pluralize(I18n.default_locale)
      end

      def get_attribute_label(field)
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if name == field
              return properties['label']
            end
          end
        end
        return "field #{field} 'label' property not found :("
      end

      def display_attributes(type)
        display_attributes = []
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if (
              properties['show'].nil? ||
              properties['show'] == 'true' ||
              (
                properties['show'] == type &&
                properties['type'] != 'adminpanel_file_field' #file fields get only displayed in form
              )
            )
              display_attributes << attribute
            end
          end
        end

        return display_attributes
      end

      def has_images?
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == 'adminpanel_file_field'
              return true
            end
          end
        end
        return false
      end

      def get_image_relationship
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == 'adminpanel_file_field'
              return attribute
            end
          end
        end
        return false
      end

      def relationships_of(type_property)
        classes_of_relation = []
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == type_property
              classes_of_relation << properties['model'].classify.constantize
            end
          end
        end
        return classes_of_relation
      end

      def icon
        'truck'
      end

      def gallery_children
        nil
      end

      def routes_options
        { path: collection_name.parameterize }
      end

      def has_route?(route)
        if (!exclude?(route)) && include_route(route)
          true
        else
          false
        end
      end

      def fb_share?
        false
      end

      def twitter_share?
        false
      end

      def member_routes
        []
      end

      def collection_routes
        []
      end

      def is_sortable?
        false
      end

      private

      def exclude?(route)
        if routes_options[:except].nil?
          false
        elsif routes_options[:except].include?(route)
          true
        else
          false
        end
      end

      def include_route(route)
        if routes_options[:only].nil? || routes_options[:only].include?(route)
          true
        else
          false
        end
      end
    end
  end
end
