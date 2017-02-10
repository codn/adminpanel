module Adminpanel
  module RouterHelper
    def gallery_is_sortable?(resource)
      resource_class(resource).has_sortable_gallery?
    end

    def sortable_galleries(resource)
      resource_class(resource).sortable_galleries
    end

    def resources_parameters(resource)
      resource_class(resource).routes_options
    end

    def has_fb_share?(resource)
      resource_class(resource).fb_share?
    end

    def has_gallery?(resource)
      resource_class(resource).has_gallery? || resource_class(resource).has_trix_gallery?
    end

    def resource_is_sortable?(resource)
      resource_class(resource).is_sortable?
    end

    def member_routes(resource)
      resource_class(resource).member_routes
    end

    def collection_routes(resource)
      resource_class(resource).collection_routes
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
