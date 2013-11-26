module Adminpanel
	class ApplicationController < ::ApplicationController
		# layout "admin"
	  	protect_from_forgery
		# include Admin::SessionsHelper

		# before_filter :signed_in_user

		# def signed_in_user
		# 	redirect_to admin_signin_url, :notice => "Favor de Iniciar sesion" unless signed_in?
		# end

		# def handle_unverified_request
		# 	sign_out
		# 	super
		# end
	end
end