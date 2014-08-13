module Adminpanel
  class <%= camelized_resource.pluralize %>Controller < Adminpanel::ApplicationController

    private
      def <%= resource_name %>_params
        params.require(:<%= resource_name %>).permit(
<%= indent("{ #{gallery_name.pluralize}_attributes: [:id, :file, :_destroy] }", 10) + ',' if has_gallery? %>
<%= indent(symbolized_attributes, 10) %>
        )
      end
  end
end
