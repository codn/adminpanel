module Adminpanel
  class SessionsController < ActionController::Base
    include SessionsHelper
    include ApplicationHelper

    layout 'adminpanel/application-login'
    before_action :configure_instagram, only: [
                                          :instagram_login,
                                          :instagram_callback
                                        ]

    def new
    end

    def create
      user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        flash[:success] = I18n.t('authentication.signin_success')
        permission = user.role.permissions.first
        if permission.nil?
          redirect_to root_url
        else
          redirect_to [route_symbol(permission.resource)]
        end
      else
        flash.now[:error] = I18n.t('authentication.signin_error')
        render 'new'
      end
    end

    def destroy
      sign_out
      redirect_to signin_path
    end

    def twitter_callback
      save_twitter_tokens
      Rails.cache.clear
      flash[:success] = I18n.t('twitter.saved_token')
      redirect_to twitter_analytics_path
    end

    def instagram_login
      redirect_to Instagram.authorize_url(redirect_uri: instagram_callback_sessions_url, scope: 'comments')
    end

    def instagram_callback
      response = Instagram.get_access_token(params[:code], redirect_uri: instagram_callback_sessions_url)
      username = Instagram.client(access_token: response.access_token).user.username
      Auth.create(key: 'instagram', value: response.access_token, name: "@#{username}")
      redirect_to instagram_analytics_path
    end

    private

    def configure_instagram
      Instagram.configure do |config|
        config.client_id = Adminpanel.instagram_client_id
        config.client_secret = Adminpanel.instagram_client_secret
      end
    end

    def save_twitter_tokens
      twitter_user = "@#{request.env['omniauth.auth']['info']['nickname']}"
      ['token', 'secret'].each do |key|
        Auth.create(
          key: "twitter-#{key}",
          name: twitter_user,
          value: request.env['omniauth.auth']['credentials'][key]
        )
      end
    end
  end
end
