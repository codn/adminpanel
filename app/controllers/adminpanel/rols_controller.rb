module Adminpanel
  class RolsController < Adminpanel::ApplicationController

    private
    def rol_params
      params.require(:rol).permit(:name, {permission_ids: []})

    end
  end
end
