module Adminpanel
  class <%= pluralized_name.capitalize %>Controller < Adminpanel::ApplicationController

    private
      def <%= lower_singularized_name %>_params
        params.require(:<%= lower_singularized_name%>).permit(
<%= indent("{ #{gallery_name.pluralize}_attributes: [:id, :file, :_destroy] }", 10) if has_gallery? %>
<%= indent(symbolized_attributes, 10) %>
        )
      end
  end
end
