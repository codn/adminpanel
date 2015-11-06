module Adminpanel
  class RolesController < Adminpanel::ApplicationController

    private
    def role_params
      params.require(:role).permit(
        :name,
        { permission_ids: [] }
      )

    end
  end
end
