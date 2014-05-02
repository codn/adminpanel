module Adminpanel
  module RouterHelper
    def gallery_children(resource)
      resource_class(resource).gallery_children
    end

    def resources_parameters(resource)
      resource_class(resource).routes_options
    end

  private
    def resource_class(resource)
      "adminpanel/#{resource.to_s.singularize}".classify.constantize
    end
  end
end
