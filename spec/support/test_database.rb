ActiveRecord::Migration.create_table :adminpanel_users do |t|
    t.string   :name
    t.string   :email
    t.string   :password_digest
    t.string   :remember_token
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_galleries do |t|
    t.string   :file
    t.integer  :position
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_images do |t|
    t.string   :file
    t.string   :section_id
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_products do |t|
    t.string   :price
    t.string   :name
    t.text     :description
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_photos do |t|
    t.string   :file
    t.text     :product_id
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_categories do |t|
    t.string   :name
    t.string   :model
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_categorizations do |t|
    t.integer  :product_id
    t.integer  :category_id
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
end
ActiveRecord::Migration.create_table :adminpanel_sections do |t|
    t.string   :name
    t.text     :description
    t.string   :key
    t.boolean  :has_image
    t.string   :page
    t.datetime :created_at,      :null => false
    t.datetime :updated_at,      :null => false
    t.boolean  :has_description
end
module ActiveModel::Validations
  def errors_on(attribute)
    self.valid?
    [self.errors[attribute]].flatten.compact
  end
  alias :error_on :errors_on
end
RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
