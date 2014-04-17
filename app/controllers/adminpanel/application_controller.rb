module Adminpanel
    class ApplicationController < ActionController::Base
        protect_from_forgery

        inherit_resources

        include SessionsHelper
        include RestActionsHelper

        layout 'admin'

        before_filter :signed_in_user, :set_model

        rescue_from CanCan::AccessDenied do |exception|
          sign_out
          redirect_to signin_path, :alert => I18n.t('authentication.not_authorized')
        end

        def signed_in_user
            redirect_to signin_url, :notice => I18n.t("authentication.welcome") unless signed_in?
        end

        def set_model
            @model = params[:controller].classify.constantize
        end

        def handle_unverified_request
            sign_out
            super
        end
    end
end
