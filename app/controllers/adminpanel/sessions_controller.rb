module Adminpanel
  class SessionsController < Adminpanel::ApplicationController
    skip_authorization_check
    layout 'admin-login'
    skip_before_filter :signed_in_user, :set_model

    def new
    end

    def create
      user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        flash[:success] = I18n.t('authentication.signin_success')
        redirect_to root_url
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
      flash[:success] = I18n.t('twitter.saved_token')
      redirect_to root_path
    end


    private
      def save_twitter_tokens
        Auth.create(
          key: 'twitter-token',
          name: "@#{request.env['omniauth.auth']['info']['nickname']}",
          value: request.env['omniauth.auth']['credentials']['token']
        )
        Auth.create(
          key: 'twitter-secret',
          name: "@#{request.env['omniauth.auth']['info']['nickname']}",
          value: request.env['omniauth.auth']['credentials']['secret']
        )
      end
  end
end
