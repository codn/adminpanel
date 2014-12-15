module Adminpanel
  module Sortable
    extend ActiveSupport::Concern
    # the lower the (position) integer is, the better it is.

    included do
      before_create :set_position
      before_destroy :rearrange_positions

      default_scope do
        order('position ASC')
      end
    end

    module ClassMethods
      def is_sortable?
        true
      end
    end

    def move_to_better_position
      if self.position > 1
        conflicting_gallery(self.position - 1).increment!(:position)
        self.decrement!(:position)

        true
      else
        false
      end
    end

    def move_to_worst_position
      records = self.class.count
      if self.position < records
        conflicting_gallery(self.position + 1).decrement!(:position)
        self.increment!(:position)
        true
      else
        false
      end
    end

    protected
      def conflicting_gallery(conflicting_position)
        logger.info "searching pos: #{conflicting_position}"
        self.class.find_by_position(conflicting_position)
      end

      def rearrange_positions
        unarranged_records = self.class.where(
          'position > ?', self.position
        )
        unarranged_records.each do |record|
          record.update_attribute(:position, gallery.position - 1)
        end

      end

      def set_position
        last_record = self.class.last
        if last_record.nil?
          # this is the first record that is created
          self.position = 1
        else
          self.position = last_record.position + 1
        end
      end
  end
end
