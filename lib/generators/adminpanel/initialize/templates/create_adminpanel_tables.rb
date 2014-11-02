class CreateAdminpanelTables < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    if direction == :up && Rails.env.development?
      role = Adminpanel::Role.new(:name => "Admin")
      role.save
      Adminpanel::User.new(:email => 'admin@admin.com', :name => "Admin", :password => 'password', :password_confirmation => 'password', :role_id => role.id).save
      puts "The password for admin@admin.com is: password"
    end
  end

  def change
    create_users
    create_galleries
    create_roles
    create_permissions
    create_auths
    create_sections
    create_sectionfiles
  end

  private
  def create_users
    create_table :adminpanel_users do |t|
      t.string  :name
      t.string  :email
      t.integer :role_id
      t.string  :password_digest
      t.string  :remember_token
      t.timestamps
    end
    add_index :adminpanel_users, [:email]
    add_index :adminpanel_users, [:remember_token]
  end

  def create_galleries
    create_table :adminpanel_galleries do |t|
      t.string  :file
      t.integer :position
      t.timestamps
    end
  end

  def create_sectionfiles
    create_table :adminpanel_sectionfiles do |t|
      t.string  :file
      t.integer :section_id
      t.timestamps
    end
  end

  def create_roles
    create_table :adminpanel_roles do |t|
      t.string :name
      t.timestamps
    end
  end

  def create_permissions
    create_table :adminpanel_permissions do |t|
        t.integer  :role_id
        t.integer  :action
        t.string   :resource
        t.timestamps
    end
  end

  def create_auths
    create_table :adminpanel_auths do |t|
      t.string   :name
      t.string   :key
      t.string   :value
      t.timestamps
    end
    add_index :adminpanel_auths, [:name]
    add_index :adminpanel_auths, [:key]
  end

  def create_sections
    create_table :adminpanel_sections do |t|
      t.string  :name
      t.boolean :has_description
      t.text    :description
      t.string  :key
      t.string  :page
      t.boolean :has_image
      t.integer :max_files
      t.timestamps
    end
    add_index :adminpanel_sections, [:key]
    add_index :adminpanel_sections, [:page]
  end
end
