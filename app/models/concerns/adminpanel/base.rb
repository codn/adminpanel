# Adminpanel API
# This file must be included on every adminpanel resource.

module Adminpanel
  module Base
    extend ActiveSupport::Concern

    module ClassMethods
      FILE_FIELD_NAME = 'adminpanel_file_field'


      def mount_images(relation)
        has_many relation, dependent: :destroy, as: :model
        accepts_nested_attributes_for relation, allow_destroy: true
        after_save :destroy_unattached_images
        after_save :correlative_order_gallery, if: Proc.new { |model| model.class.has_sortable_gallery? }
      end

      # implementing cache by default.
      def belongs_to(name, scope = nil, **options)
        super(name, scope, options.reverse_merge!({touch: true}))
      end

      # The fields and the types that should be used to generate form
      # and display fields
      def form_attributes
        []
      end

      # The name that is going to be shown in the new button and that is going
      # to be pluralized (if not overwritten) to generate collection_name
      def display_name
        'please overwrite self.display_name'
      end

      # fontawesome icon to be used in the side-menu
      def icon
        'truck'
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
        return field
      end

      # returns the attributes that should be shown in the correspondin view
      # (some attributes may be filtered from the index table, from the show
      # or even both)
      def display_attributes(type)
        display_attributes = []
        form_attributes.each do |attribute|
          attribute.each do |_, properties|
            if (
              properties['show'].nil? ||
              properties['show'] == 'true' ||
              (
                properties['show'] == type &&
                properties['type'] != FILE_FIELD_NAME #file fields get only displayed in form
              )
            )
              display_attributes << attribute
            end
          end
        end
        return display_attributes
      end

      # Check if this models has a gallery in its attributes
      # @return boolean
      def has_gallery?
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == FILE_FIELD_NAME
              return true
            end
          end
        end
        false
      end

      # Check if this models has a trix editor with a gallery in its attributes
      # @return boolean
      def has_trix_gallery?
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == 'wysiwyg_field' && properties['uploader'].present?
              return true
            end
          end
        end
        false
      end

      # Returns an array with all the adminpanel_file_field`s attributes found
      # in form_attributes
      # @return Hash
      # => { sectionfiles: Adminpanel::SectionFile, ... }
      def galleries
        galleries = {}
        form_attributes.each do |fields|
          fields.each do |relation, properties|
            if properties['type'] == FILE_FIELD_NAME
              galleries["#{relation.singularize}"] = "adminpanel/#{relation}".classify.constantize.to_s
            end
          end
        end

        return galleries
      end

      # Returns an array with all the adminpanel_file_field`s attributes who are
      # sortable found in form_attributes
      # @return Hash
      def sortable_galleries
        galleries = {}
        form_attributes.each do |fields|
          fields.each do |relation, properties|
            if properties['type'] == FILE_FIELD_NAME && "adminpanel/#{relation}".classify.constantize.is_sortable?
              galleries["#{relation.singularize}"] = "adminpanel/#{relation}".classify.constantize.to_s
            end
          end
        end

        galleries
      end

      # returns the attribute that should be namespaced to be the class
      # ex: returns 'productfiles', so class is Adminpanel::Productfile
      def gallery_relationship
        form_attributes.each do |fields|
          fields.each do |attribute, properties|
            if properties['type'] == FILE_FIELD_NAME
              return attribute
            end
          end
        end
        return false
      end

      # gets the class gallery and return it's class
      def gallery_class
        "adminpanel/#{gallery_relationship}".classify.constantize
      end

      # Search for a model attribute's that are of a given type
      # @return Array
      # Usage:
      # To get all classes of all belongs_to attributes:
      #   @model.relationships_of('belongs_to')
      #   # => ['Adminpanel::Category', Adminpanel::ModelBelongTo]
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

      # routes options to be used when generating this model routes
      # @return Hash
      def routes_options
        { path: collection_name.parameterize }
      end

      def has_route?(route)
        if (!exclude_route?(route)) && include_route?(route)
          true
        else
          false
        end
      end

      def fb_share?
        false
      end

      # Additional member routes for this resource
      def member_routes
        []
      end

      # Additional collection routes for this resource
      def collection_routes
        []
      end

      def is_sortable?
        false
      end

      def has_sortable_gallery?
        !sortable_galleries.empty?
      end

      def to_controller_name
        to_s.demodulize.underscore.pluralize
      end

      def form_url
        self
      end

      private

        def exclude_route?(route)
          if routes_options[:except].nil?
            false
          elsif routes_options[:except].include?(route)
            true
          else
            false
          end
        end

        def include_route?(route)
          if routes_options[:only].nil? || routes_options[:only].include?(route)
            true
          else
            false
          end
        end

      end

      def destroy_unattached_images
        self.class.galleries.each{|gallery| gallery.last.constantize.where(model_id: nil).delete_all }
      end

      def correlative_order_gallery
        self.class.galleries.each do |gallery|
          self.send(gallery.first.pluralize).ordered.each_with_index{ |image, index| image.update(position: index + 1) }
        end
      end
  end
end
