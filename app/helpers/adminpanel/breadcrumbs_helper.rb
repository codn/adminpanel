module Adminpanel
  module BreadcrumbsHelper

    def breadcrumb_add(title, url)
      initialize_breadcrumb << { title: title, url: url }
    end

    def render_breadcrumb(divider)
      render partial: 'adminpanel/shared/breadcrumb', locals: { nav: initialize_breadcrumb, divider: divider }
    end

    private
    def initialize_breadcrumb
      @breadcrumb ||= [{ title: I18n.t('breadcrumb.index'), url: adminpanel.root_url }, ]
    end

  end
end
