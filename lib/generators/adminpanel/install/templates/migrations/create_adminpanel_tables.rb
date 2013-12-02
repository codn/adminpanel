class CreateAdminpanelTables < ActiveRecord::Migration
	def change
		create_table :adminpanel_products do |t|
	      t.integer :category_id
	      t.string :name
	      t.string :brief
	      t.text :description
	      t.timestamps
	    end

	    create_table :adminpanel_users do |t|
	      t.string :name
	      t.string :email
	      t.string :password_digest
	      t.string :remember_token
	      t.timestamps
	    end
	    add_index :adminpanel_users, [:email]
	    add_index :adminpanel_users, [:remember_token]

        create_table :adminpanel_galleries do |t|
	      t.string :file
	      t.timestamps
	    end

	    create_table :adminpanel_images do |t|
	      t.string :file
	      t.integer :foreign_key
	      t.string :model
	      t.timestamps
	    end

	    create_table :adminpanel_sections do |t|
	      t.string :name
	      t.boolean :has_description
	      t.text :description
	      t.string :key
	      t.boolean :has_image
	      t.string :file
	      t.timestamps
	    end
	    add_index :adminpanel_sections, [:key]

	    create_table :adminpanel_categories do |t|
	      t.string :name
	      t.timestamps
	    end
	end
end