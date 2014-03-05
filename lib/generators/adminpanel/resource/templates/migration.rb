class Create<%= pluralized_name.capitalize %>Table < ActiveRecord::Migration
  	def change
		create_table :adminpanel_<%= pluralized_name %> do |t|

			<%- fields.each do |attribute| -%>
      <%- assign_attributes_variables(attribute) -%>
			<%= migration_string(@attr_field, @attr_type) %>
      <%- end -%>
      
			t.timestamps
		end
  end
end
