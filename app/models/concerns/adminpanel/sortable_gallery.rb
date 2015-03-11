module Adminpanel
  module SortableGallery
    extend ActiveSupport::Concern

    included do
      before_create :set_position
      before_destroy :rearrange_positions

      scope :ordered, -> { order('position ASC') }
    end

    module ClassMethods
      def in_better_position(current_position, new_position, relation_id)
        where(
          'position >= ? AND position < ?',
          new_position,
          current_position
        ).where(
          relation_field => relation_id
          # => 'product_id' => member.product_id
        )
      end

      def in_worst_position(current_position, new_position, relation_id)
        where(
          'position > ? AND position <= ?',
          current_position,
          new_position
        ).where(
          relation_field => relation_id
          # => 'product_id' => member.product_id
        )
      end
    end

    def move_to_position(new_position)
      if new_position < position
        # search for better elements and downgrade them
        self.class.in_better_position(
          self.position,
          new_position,
          self.send(self.class.relation_field)
        ).update_all('position = position + 1')
      else
        # search for worster elements and upgrade them
        self.class.in_worst_position(
          self.position,
          new_position,
          self.send(self.class.relation_field)
        ).update_all('position = position - 1')
      end
      self.update(position: new_position)
    end

    # we should detect if the name isn't defined in the class
    def name
      I18n.t('gallery.image')
    end

  protected

    def rearrange_positions
      self.class.where(
        self.class.relation_field => self.send(
          self.class.relation_field
        )
      ).where(
        'position > ?',
        self.position
      ).update_all('position = position - 1')
    end

    def set_position
      last_record = self.class.where(
        self.class.relation_field => self.send(
          self.class.relation_field
        )
      ).ordered.last
      if last_record.nil?
        self.position = 1
      else
        self.position = last_record.position + 1
      end
    end
  end
end
