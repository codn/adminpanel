module Adminpanel
    class ApplicationController < ActionController::Base
        protect_from_forgery

        inherit_resources

        include SessionsHelper
        include RestActionsHelper

        layout "admin"

        before_filter :signed_in_user

        def signed_in_user
            redirect_to signin_url, :notice => "Favor de Iniciar sesion" unless signed_in?
        end

        def handle_unverified_request
            sign_out
            super
        end
    end
end