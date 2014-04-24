module Adminpanel
  class <%= capitalized_resource %> < ActiveRecord::Base
    include Adminpanel::Base

    <%= associations if has_associations? -%>

    def self.form_attributes
      [<%= adminpanel_form_attributes %>
      ]
    end

    def self.display_name
      '<%= capitalized_resource %>'
    end

    # def self.icon
    #     "icon-truck"
    # end
  end
end
