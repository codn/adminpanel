module Adminpanel
  class <%= class_name %> < ActiveRecord::Base
    # include Adminpanel::Base # required for galleryzation
    # include Adminpanel::Galleryzation

    # belongs_to :<%= reference_name %>

    mount_uploader :file, <%= class_name %>Uploader

    before_destroy :remove_attachment

    # def self.relation_field
    #   '<%= reference_name %>_id'
    # end

    # def self.display_name
    #   '<%= class_name %>'
    # end

    private
      def remove_attachment
        self.remove_file!
      end
  end
end
