module Adminpanel
  class <%= pluralized_name.capitalize %>Controller < Adminpanel::ApplicationController

    private
      def <%= lower_singularized_name %>_params
        params.require(:<%= lower_singularized_name%>).permit(<%= symbolized_attributes %>)
      end
  end
end
