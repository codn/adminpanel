require "spec_helper"

describe "adminpanel:resource" do
	context "with no arguments or options" do
      it "should generate the migration" do
      	subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_resources_table.rb") { |content|
      		content.should =~ /class CreateResourcesTable < ActiveRecord\:\:Migration/
      	}
      end
      it {subject.should generate("app/models/adminpanel/resource.rb")}
      it {subject.should generate("app/controllers/adminpanel/resources_controller.rb")}
	end

	with_args :category do
		it "should generate categories migration" do
			subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_categories_table.rb")
		end
		it "should generate categories controller" do
			subject.should generate("app/controllers/adminpanel/categories_controller.rb")
		end
		it "should generate category model" do
			subject.should generate("app/models/adminpanel/category.rb")
		end
	end

	with_args "Product" do
		with_args :"description:wysiwyg" do
			
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.text \:description/
				}
			end	
		end		

		with_args :"long_text:text" do
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.text \:long_text/
				}
			end
		end

		with_args :"price:float" do
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.float \:price/
				}
			end
		end

		with_args :"date:datepicker" do
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.string \:date/
				}
			end
		end

		with_args :"quantity:integer" do
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.integer \:quantity/
				}
			end
		end

		with_args :"image:images" do
			it "should generate model with image relationship" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /has_many :images, :foreign_key => "foreign_key", :conditions => \{ :model => "product" \}/
				}
			end

			it "should accept nested attributes for image" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /accepts_nested_attributes_for :images, :allow_destroy => true/
				}
			end
		end

		with_args "name:string" do
			it "should generate products migration with attributes" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.string \:name/
				}
			end
		end

		with_args :"name:string", :"description:wysiwyg" do
			it "should generate namespaced products_controller.rb" do
				subject.should generate("app/controllers/adminpanel/products_controller.rb") { |content|
					content.should == 
"module Adminpanel
    class ProductsController < Adminpanel::ApplicationController
    end
end"
				}
			end

			it "should generate model with attr_accessible" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /attr_accessible/
				}
			end
			
			it "should generate model with description hash" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /\{\"description\" => \{\"type\" => \"wysiwyg_field\", \"name\" => \"description\", \"label\" => \"description\", \"placeholder\" => \"description\"\}\}/
				}
			end

			it "should generate model with name hash" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /\{\"name\" => \{\"type\" => \"text_field\", \"name\" => \"name\", \"label\" => \"name\", \"placeholder\" => \"name\"\}\}/
				}
			end

			it "should generate model with overwritten sample_name" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /def self.display_name\n            \"Product\"\n        end/
				}
			end
		end
	end
end