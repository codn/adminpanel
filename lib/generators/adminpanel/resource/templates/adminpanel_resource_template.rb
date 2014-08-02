module Adminpanel
  class <%= camelized_resource %> < ActiveRecord::Base
    include Adminpanel::Base

    <%= associations if has_associations? -%>
    <%= get_gallery if has_gallery? -%>

    def self.form_attributes
      [
<%= indent(get_attribute_hash, 8) + ',' %>
<%= indent(file_field_form_hash, 8) if has_gallery? %>
      ]
    end

    def self.display_name
      '<%= camelized_resource %>' #singular
    end

    # def self.icon
    #   "truck" # fa-{icon}
    # end
  end
end
