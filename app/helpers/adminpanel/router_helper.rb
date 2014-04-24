module Adminpanel
  module RouterHelper
    def acts_as_a_gallery?(resource)
      "adminpanel/#{resource}_controller".classify.constantize.resource_class.gallery_children
    end
  end
end
