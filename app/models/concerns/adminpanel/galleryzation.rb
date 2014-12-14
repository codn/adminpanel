module Adminpanel
  module Galleryzation
    extend ActiveSupport::Concern

    included do
      before_create :set_position
      before_destroy :rearrange_positions

      default_scope do
        order('position ASC')
      end
    end

    def move_to_better_position
      if self.position > 1
        conflicting_gallery = get_conflicting_gallery(position - 1)

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
        conflicting_gallery = get_conflicting_gallery(position + 1)

        update_attribute(:position, self.position + 1)

        conflicting_gallery.update_attribute(
          :position, conflicting_gallery.position - 1
        )
        true
      else
        false
      end
    end

  protected
    def get_conflicting_gallery(conflicting_position)
      self.class.where(
        self.class.relation_field => self.send(self.class.relation_field)
      ).find_by_position(conflicting_position)
    end

    def rearrange_positions
      unarranged_galleries = self.class.where(
        self.class.relation_field => self.send(
          self.class.relation_field
        )
      ).where('position > ?', self.position)
      unarranged_galleries.each do |gallery|
        gallery.update_attribute(:position, gallery.position - 1)
      end

    end

    def set_position
      last_record = self.class.where(
        self.class.relation_field => self.send(
          self.class.relation_field
        )
      ).last
      if last_record.nil?
        self.position = 1
      else
        self.position = last_record.position + 1
      end
    end
  end
end
