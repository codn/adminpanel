module Adminpanel
  class UsersController < Adminpanel::ApplicationController
    # authorize_resource :class => false
    authorize_resource

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
