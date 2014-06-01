module Adminpanel
  module RouterHelper
    def get_gallery_children(resource)
      resource_class(resource).gallery_children
    end

    def resources_parameters(resource)
      resource_class(resource).routes_options
    end

    def has_fb_share?(resource)
      resource_class(resource).fb_share?
    end

    def rest_path_names
      {
        path_names: {
          new: I18n.t('routes.new'),
          edit: I18n.t('routes.edit'),
          show: I18n.t('routes.show')
        }
      }
    end
  private
    def resource_class(resource)
      "adminpanel/#{resource.to_s.singularize}".classify.constantize
    end
  end
end
