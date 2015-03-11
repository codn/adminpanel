module Adminpanel
  module Sortable
    extend ActiveSupport::Concern
    # the lower the (position) integer is, the better it is.

    included do
      before_create :set_position
      before_destroy :rearrange_positions
    end

    module ClassMethods
      def is_sortable?
        true
      end

      def ordered
        order('position ASC')
      end

      def in_better_position(current_position, new_position)
        where(
          'position >= ? AND position < ?',
          new_position,
          current_position
        )
      end

      def in_worst_position(current_position, new_position)
        where(
          'position > ? AND position <= ?',
          current_position,
          new_position
        )
      end
    end

    def move_to_position(new_position)
      if new_position < position
        # search for better elements and downgrade them
        self.class.in_better_position(
          self.position,
          new_position
        ).update_all('position = position + 1')
      else
        # search for worster elements and upgrade them
        self.class.in_worst_position(
          self.position,
          new_position
        ).update_all('position = position - 1')
      end
      self.update(position: new_position)
    end

    protected

      def rearrange_positions
        self.class.where(
          'position > ?', self.position
        ).update_all('position = position - 1')
      end

      def set_position
        last_record = self.class.ordered.last
        if last_record.nil?
          # this is the first record that is created
          self.position = 1
        else
          self.position = last_record.position + 1
        end
      end
  end
end
