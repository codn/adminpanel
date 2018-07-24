module Adminpanel
  class AnalyticsController < Adminpanel::ApplicationController
    include Adminpanel::Analytics::InstagramAnalytics

    skip_before_action :set_resource_collection

    before_action :set_fb_token

    def index
    end

    def instagram
      authorize! :read, Adminpanel::Analytic
      if !@instagram_token.nil?
        @user = @instagram_client.user
      end
    end

    private

      def set_fb_token
        @fb_auth = Adminpanel::Auth.find_by_key('facebook')
      end

  end
end
