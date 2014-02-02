module Adminpanel
    class <%= capitalized_resource %> < ActiveRecord::Base
        attr_accessible <%= symbolized_attributes %>
        <%= image_relationship if has_images? %>

        def self.form_attributes
            [<%= adminpanel_form_attributes %>
            ]
        end

        def self.display_name
            "<%= capitalized_resource %>"
        end
    end
end