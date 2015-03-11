module Adminpanel
  module BreadcrumbsHelper

    def breadcrumb_add(title, url)
      breadcrumb << { title: title, url: url }
    end

    def render_breadcrumb(divider)
      render 'adminpanel/shared/breadcrumb', nav: breadcrumb, divider: divider
    end

    private

      def breadcrumb
        @breadcrumb ||= [{ title: I18n.t('breadcrumb.index'), url: adminpanel.root_url }]
      end

  end
end
