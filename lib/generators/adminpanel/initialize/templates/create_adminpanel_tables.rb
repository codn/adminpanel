class CreateAdminpanelTables < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    if direction == :up
      if Rails.env.development?
        rol = Adminpanel::Group.new(:name => "Admin")
        rol.save
        Adminpanel::User.new(:email => 'admin@admin.com', :name => "Admin", :password => 'password', :password_confirmation => 'password', :rol_id => rol.id).save
        puts "The password for admin@admin.com is: password"

      end
    end
  end

  def change
      create_table :adminpanel_users do |t|
        t.string :name
        t.string :email
        t.string :rol_id
        t.string :password_digest
        t.string :remember_token
        t.timestamps
      end
      add_index :adminpanel_users, [:email]
      add_index :adminpanel_users, [:remember_token]

        create_table :adminpanel_galleries do |t|
        t.string :file
        t.integer :position
        t.timestamps
      end

      create_table :adminpanel_images do |t|
        t.string :file
        t.integer :section_id
        t.timestamps
      end

      create_table :adminpanel_rols do |t|
        t.string :name
        t.timestamps
      end

      create_table :adminpanel_auths do |t|
        t.string   :name
        t.string   :key
        t.string   :value
        t.datetime :created_at,      :null => false
        t.datetime :updated_at,      :null => false
      end
      add_index :adminpanel_auths, [:name]
      add_index :adminpanel_auths, [:key]

      create_table :adminpanel_sections do |t|
        t.string :name
        t.boolean :has_description
        t.text :description
        t.string :key
        t.string :page
        t.boolean :has_image
        t.timestamps
      end

      add_index :adminpanel_sections, [:key]
      add_index :adminpanel_sections, [:page]
  end
end
