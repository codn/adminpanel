class Create<%= pluralized_name.capitalize %>Table < ActiveRecord::Migration
  	def change
		create_table :adminpanel_<%= pluralized_name %> do |t|
			<% fields.each do |field, type| %>
			<%= migration_string(field, type) %><% end %>
			t.timestamps
		end
 	end
end
