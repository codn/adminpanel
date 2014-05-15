module Adminpanel
  class ApplicationController < ActionController::Base
    protect_from_forgery

    inherit_resources

    include SessionsHelper
    include Adminpanel::RestActions
    include Adminpanel::GalleryzableActions

    layout 'admin'
    before_filter :signed_in_user, :set_model, :strong_params_for_cancan


  private
    def strong_params_for_cancan
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"
      params[resource] &&= send(method) if respond_to?(method, true)
    end

    rescue_from CanCan::AccessDenied do |exception|
      sign_out
      redirect_to signin_path, :alert => I18n.t('authentication.not_authorized')
    end

    def signed_in_user
      redirect_to signin_url, :notice => I18n.t('authentication.welcome') unless signed_in?
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
