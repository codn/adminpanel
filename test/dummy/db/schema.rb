# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define do
  create_table :adminpanel_users do |t|
      t.string   :name
      t.string   :email
      t.string   :password_digest
      t.string   :remember_token
      t.integer  :role_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_galleries do |t|
      t.string   :file
      t.integer  :position
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_sectionfiles do |t|
      t.string   :file
      t.string   :section_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_products do |t|
      t.string   :price
      t.string   :name
      t.text     :description
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_photos do |t|
      t.string   :file
      t.text     :product_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_categories do |t|
      t.string   :name
      t.string   :model
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_auths do |t|
      t.string   :name
      t.string   :key
      t.string   :value
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_categorizations do |t|
      t.integer  :product_id
      t.integer  :category_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_items do |t|
      t.integer  :product_id
      t.integer  :deparment_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_departments do |t|
      t.integer  :category_id
      t.integer  :name
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_roles do |t|
      t.string   :name
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_permissions do |t|
      t.integer  :role_id
      t.integer  :action
      t.string   :resource
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_mugs do |t|
      t.string   :name
      t.integer  :number
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_salesmen do |t|
      t.string   :name
      t.integer  :product_id
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
  end
  create_table :adminpanel_sections do |t|
      t.string   :name
      t.text     :description
      t.string   :key
      t.boolean  :has_image
      t.integer  :max_images,      default: 0
      t.string   :page
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
      t.boolean  :has_description
  end
  create_table :adminpanel_test_objects do |t|
      t.boolean  :boolean
      t.string   :name
      t.text     :text
      t.integer  :quantity
      t.float    :price
      t.datetime :created_at,      null: false
      t.datetime :updated_at,      null: false
      t.boolean  :has_description
  end
  create_table :adminpanel_test_object_category do |t|
      t.integer  :test_object_id
      t.integer  :category_id
  end
end
