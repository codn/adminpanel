class CreateAdminpanel<%= class_name.pluralize %> < ActiveRecord::Migration
  def change
    create_table :adminpanel_<%= lower_name.pluralize %> do |t|

      t.integer :<%= reference_name %>_id
      t.string :file

      t.timestamps
    end
  end
end
