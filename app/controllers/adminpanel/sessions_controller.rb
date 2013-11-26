module Adminpanel
	class SessionsController < Adminpanel::ApplicationController
		layout 'sessions'
		skip_before_filter :signed_in_user

		def new
		end

		def create
			user = User.find_by_email(params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
					sign_in user
					flash[:success] = "Bienvenido!"
					redirect_to admin_root_url
			else
				flash.now[:error] = "Password Incorrecto"
				render 'new'
			end
		end

		def destroy
			sign_out
			redirect_to root_url
		end
	end
end