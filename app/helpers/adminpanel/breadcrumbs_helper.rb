module Adminpanel
  module BreadcrumbsHelper

    def breadcrumb_add(title, url)
      initialize_breadcrumb << { title: title, url: url }
    end

    def render_breadcrumb(divider)
      render partial: 'shared/breadcrumb', locals: { nav: initialize_breadcrumb, divider: divider }
    end

    private
    def initialize_breadcrumb
      @breadcrumb ||= [{ title: 'Inicio', url: adminpanel.root_url }, ]
    end

  end
end
