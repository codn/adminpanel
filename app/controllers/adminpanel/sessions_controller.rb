module Adminpanel
	class SessionsController < Adminpanel::ApplicationController

		layout "admin-login"
		skip_before_filter :signed_in_user, :set_model

		def new
			respond_to do |format|
				format.html
				format.json { render :json => {:session => @session }}
			end
		end

		def create
			user = User.find_by_email(params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
					sign_in user
					flash[:success] = I18n.t("authentication.signin success")
					redirect_to root_url
			else
				flash.now[:error] = I18n.t("authentication.signin error")
				render 'new'
			end
		end

		def destroy
			sign_out
			redirect_to signin_path
		end
	end
end
