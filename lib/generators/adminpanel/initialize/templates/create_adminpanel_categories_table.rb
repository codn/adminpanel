class CreateAdminpanelCategoriesTable < ActiveRecord::Migration
  	def change
    create_table :adminpanel_categories do |t|


      t.string :name
      t.string :model
      t.timestamps
    end
 	end
end
