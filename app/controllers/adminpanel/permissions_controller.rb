module Adminpanel
  class PermissionsController < Adminpanel::ApplicationController

    private
      def permission_params
        params.require(:permission).permit(
          :role_id,
          :action,
          :resource
        )
      end
  end
end
