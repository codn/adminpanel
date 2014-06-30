module Adminpanel
  module InstagramAnalytics
    extend ActiveSupport::Concern

    included do
      before_filter :set_instagram_token, only:[:instagram, :instagram_comment]
    end

    def instagram_comment

      response = @instagram_client.create_media_comment params[:id], params[:instagram_text]
      debugger
      redirect_to instagram_analytics_path
    end

  private
    def set_instagram_token
      @instagram_token = Auth.find_by_key 'instagram'

      if !@instagram_token.nil?
        @instagram_client ||= Instagram.client(

          access_token: @instagram_token.value
          )
      end
    end

  end
end
