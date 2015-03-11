module Adminpanel
  class Photo < ActiveRecord::Base
    include Adminpanel::Base
    # include Adminpanel::SortableGallery
    mount_uploader :file, PhotoUploader
    belongs_to :product

    def self.relation_method
      'product_id'
    end

  end
end
