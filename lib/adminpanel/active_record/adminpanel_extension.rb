module ActiveRecord
  module AdminpanelExtension
    extend ActiveSupport::Concern
    #instance methods
    def move_to_better_position
      if self.position > 1
        conflicting_gallery = self.class.where(self.class.relation_field => self.send(self.class.relation_field)).find_by_position(position - 1)
        self.update_attribute(:position, self.position - 1)
        conflicting_gallery.update_attribute(
          :position, conflicting_gallery.position + 1
          )
        true
      else
        false
      end
    end

    def move_to_worst_position
      records = self.class.count
      if self.position < records
        conflicting_gallery = self.class.where(self.class.relation_field => self.send(self.class.relation_field)).find_by_position(position + 1)
        update_attribute(:position, self.position + 1)
        conflicting_gallery.update_attribute(
          :position, conflicting_gallery.position - 1
          )
        true
      else
        false
      end
    end

    # static(class) methods
    module ClassMethods
      def mount_images(relation)
        has_many relation, :dependent => :destroy
		    accepts_nested_attributes_for relation, :allow_destroy => true
      end

      def act_as_a_gallery
        before_create :set_position
        before_destroy :rearrange_positions

        default_scope { order("position ASC")}
      end

      def form_attributes
        [{
          "name" => {
            "type" => "text_field",
            "label" => "name"
          }
        }]
      end

      def display_name
        "display_name"
      end

      def get_attribute_name(field)
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if name == field
              return properties["label"]
            end
          end
        end
        return ":("
      end

      def get_attribute_label(field)
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if name == field
              return properties["label"]
            end
          end
        end
        return ":("
      end

      def get_attribute_placeholder(field)
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if name == field
              return properties["placeholder"]
            end
          end
        end
        return ":("
      end

      def display_attributes(type)
        display_attributes = []
        form_attributes.each do |attribute|
          attribute.each do |name, properties|
            if properties['show'].nil? ||
              properties['show'] == 'true' ||
              properties['show'] == type
              display_attributes << attribute
            end
          end
        end

        return display_attributes
      end

      def has_images?
        form_attributes.each do |fields|
        fields.each do |attribute, properties|
          if properties["type"] == "adminpanel_file_field"
            return true
          end
        end
        end
        return false
      end

      def get_image_relationship
        form_attributes.each do |fields|
        fields.each do |attribute, properties|
          if properties["type"] == "adminpanel_file_field"
            return attribute
          end
        end
        end
        return false
      end

      def belongs_to_relationships
        belongs_to_classes = []
        form_attributes.each do |fields|
        fields.each do |attribute, properties|
          if properties["type"] == "belongs_to"
            belongs_to_classes << properties["model"].classify.constantize
          end
        end
        end
        return belongs_to_classes
      end

      def has_many_relationships
        has_many_classes = []
        form_attributes.each do |fields|
        fields.each do |attribute, properties|
          if properties["type"] == "has_many"
            has_many_classes << properties["model"].classify.constantize
          end
        end
        end
        return has_many_classes
      end

      def icon
        "icon-truck"
      end

      def act_as_a_gallery?
        nil
      end

      def self.relation_field
        'undefined_relation_field'
      end
    end

  private
    def rearrange_positions
      unarranged_galleries = self.class.where(self.class.relation_field => self.send(self.class.relation_field)).where("position > ?", self.position)
      unarranged_galleries.each do |gallery|
        gallery.update_attribute(:position, gallery.position - 1)
      end

    end

    def set_position
      last_record = self.class.where(self.class.relation_field => self.send(self.class.relation_field)).last
      if last_record.nil?
        self.position = 1
      else
        self.position = last_record.position + 1
      end
    end

  end
  # include the extension
  ActiveRecord::Base.send(:include, AdminpanelExtension)
end
