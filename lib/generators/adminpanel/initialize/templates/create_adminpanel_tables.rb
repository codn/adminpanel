class CreateAdminpanelTables < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    if direction == :up && Rails.env.development?
      role = Adminpanel::Role.new(name: "Admin")
      role.save
      Adminpanel::User.new(email: 'webmaster@codn.mx', name: "Admin", password: '123456', password_confirmation: '123456', role_id: role.id).save
      puts "The password for admin@admin.com is: 123456"
    end
  end

  def change
    create_users
    create_roles
    create_permissions
    create_auths
    create_sections
    create_images
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

  def create_images
    create_table :adminpanel_images do |t|
      t.string :file
      t.integer :model_id
      t.string :model_type
      t.string :type
      t.string :file_size
      t.string :content_type
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
      t.integer :max_files, default: 0
      t.integer :order
      t.timestamps
    end
    add_index :adminpanel_sections, [:key]
    add_index :adminpanel_sections, [:page]
  end
end
