module Adminpanel
    class ApplicationController < ActionController::Base
        protect_from_forgery

        inherit_resources

        include SessionsHelper
        include RestActionsHelper
        include RouterHelper

        layout "admin"

        before_filter :signed_in_user, :set_model, :get_menu_elements


        def signed_in_user
            redirect_to signin_url, :notice => "Favor de Iniciar sesion" unless signed_in?
        end

        def set_model
            @model = params[:controller].classify.constantize
        end

        def handle_unverified_request
            sign_out
            super
        end

        def get_menu_elements
            @menu_items = menu_items
        end
    end
end