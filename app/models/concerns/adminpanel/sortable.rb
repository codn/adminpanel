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

    # instance methods
    def move_to_position(new_position)
      if new_position < position
        # moving to a better priority
        self.class.where(
          'position >= ? AND position < ?',
          new_position,
          position
        ).update_all('position = position + 1')
      else
        self.class.where(
          'position <= ? AND position > ?',
          new_position,
          position
        ).update_all('position = position - 1')
      end
      self.update(position: new_position)
    end

    protected

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
