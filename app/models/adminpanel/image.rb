module Adminpanel
  class Image < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :model, polymorphic: true, optional: true

    before_save :store_file_size_and_content_type

    before_destroy :remove_attachment

    private
      def remove_attachment
        self.remove_file!
      end

      def store_file_size_and_content_type
        if file.present?
          self.content_type = file.file.content_type
          self.file_size = file.file.size
        end
      end

  end
end
