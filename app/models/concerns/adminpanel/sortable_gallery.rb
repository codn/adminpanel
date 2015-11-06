module Adminpanel
  module SortableGallery
    extend ActiveSupport::Concern

    included do
      before_create :set_position
      before_destroy :rearrange_positions

      scope :ordered, -> { order('position ASC') }
    end

    module ClassMethods
      def is_sortable?
        true
      end

      def in_better_position(current_position, new_position, record_id)
        where(
          'position >= ? AND position < ?',
          new_position,
          current_position
        ).where(
          model_id: record_id,
          type: self.to_s
        )
      end

      def in_worst_position(current_position, new_position, record_id)
        where(
          'position > ? AND position <= ?',
          current_position,
          new_position
        ).where(
          model_id: record_id,
          type: self.to_s
        )
      end
    end

    def move_to_position(new_position)
      if new_position < position
        # search for better elements and downgrade them
        self.class.in_better_position(
          self.position,
          new_position,
          self.model_id
        ).update_all('position = position + 1')
      else
        # search for worster elements and upgrade them
        self.class.in_worst_position(
          self.position,
          new_position,
          self.model_id
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
        'position > ?',
        self.position
      ).where(
        model_id: self.model_id,
        model_type: self.model_type
      ).update_all('position = position - 1')
    end

    def set_position
      last_record = self.class.ordered.last
      if last_record.nil?
        self.position = 1
      else
        self.position = last_record.position + 1
      end
    end
  end
end
