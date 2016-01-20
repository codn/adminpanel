module Adminpanel
  class Image < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :model, polymorphic: true

    before_save :store_file_size_and_content_type
    # after_save :delete_old_unused_images
    before_destroy :remove_attachment

    private
      def remove_attachment
        self.remove_file!
      end

      def store_file_size_and_content_type
        if file.present? && file_changed?
          self.content_type = file.file.content_type
          self.file_size = file.file.size
        end
      end

      # def delete_old_unused_images
      #   self.class.where('created_at < ?', Time.now - 30.minutes)
      #             .delete_all(
      #               model_id: nil,
      #               type: self.type
      #             )
      # end
  end
end
