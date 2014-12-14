module Adminpanel
  module SitemapActions
    extend ActiveSupport::Concern
    included do
      before_action :set_default_host, only:[:create, :update, :destroy]
    end

    protected
    def set_default_host
      Rails.application.routes.default_url_options[:host] = request.host
    end
  end
end
