module Adminpanel
  class UsersController < Adminpanel::ApplicationController
    
  private
    def user_params
      params.require(:user).permit(
        :email,
        :name,
        :password,
        :password_confirmation,
        :rol_id
      )
    end
  end
end
