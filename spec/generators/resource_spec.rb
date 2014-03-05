require "spec_helper"

describe "adminpanel:resource" do
	
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

		context "with has_many and belongs_to" do
			with_args :"products,categorizations:has_many_through", :"product:belongs_to" do
				it "should generate categories migration" do
					subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_categories_table.rb") { |content|
						content.should =~ /t.integer \:product_id/ &&
						(
							content.should_not =~ /t.integer \:products_id/ ||
							content.should_not =~ /t.integer \:categorizations_id/
						)
					}
				end

				it "should generate model with has_many categorizations" do
					subject.should generate("app/models/adminpanel/category.rb") { |content|
						content.should =~ /has_many \:categorizations/
					}
				end

				it "should generate model with has_many products through categorizations" do
					subject.should generate("app/models/adminpanel/category.rb") { |content|
						content.should =~ /has_many \:products, \:through => \:categorizations/
					}
				end

				it "should generate categories model" do
					subject.should generate("app/models/adminpanel/category.rb") { |content|
						content.should =~ /belongs_to :product/
					}
				end
			end
		end
	end

	with_args :categorization do
		context "with only :belongs_to as types" do
			with_args :"product:belongs_to", :"category:belongs_to" do
				it "should generate categorizations migration" do
					subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_categorizations_table.rb") { |content|
						content.should =~ /t.integer \:product_id/ &&
						content.should =~ /t.integer \:category_id/
					}
				end

				it "shouldn't generate categorizations controller" do
					subject.should_not generate("app/controllers/adminpanel/categorizations_controller.rb")
				end

				it "should generate categorization model" do
					subject.should generate("app/models/adminpanel/categorization.rb") { |content|
						content.should =~ /belongs_to :product/ &&
						content.should =~ /belongs_to :category/
					}
				end
			end
		end
	end

	with_args "Product" do
		with_args :"description:wysiwyg", :"long_text:text",
					:"price:float", :"date:datepicker",
					:"name:string", :"quantity:integer" do
			it "should generate migration with correct values" do
				subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_products_table.rb") { |content|
					content.should =~ /t.text \:description/ &&
					content.should =~ /t.text \:long_text/ &&
					content.should =~ /t.float \:price/ &&
					content.should =~ /t.string \:date/ &&
					content.should =~ /t.string \:name/ &&
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


		with_args :"name:string", :"description:wysiwyg" do
			it "should generate namespaced products_controller.rb" do
				subject.should generate("app/controllers/adminpanel/products_controller.rb") { |content|
					content.should =~ /module Adminpanel/ &&
					content.should =~ /class ProductsController < Adminpanel\:\:ApplicationController/ &&
					content.should =~ /end\nend/
				}
			end

			it "should generate model with attr_accessible" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /attr_accessible/
				}
			end

			it "should generate model with description hash" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /\{\"description\" => \{/ &&
					content.should =~ /\"type\" => \"wysiwyg_field\", /&&
					content.should =~ /\"name\" => \"description\", / &&
					content.should =~ /\"label\" => \"description\", / &&
					content.should =~ /\"placeholder\" => \"description\"\}\}/
				}
			end

			it "should generate model with name hash" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /\{\"name\" => \{/
					content.should =~ /\"type\" => \"text_field\", /
					content.should =~ /\"name\" => \"name\", /
					content.should =~ /\"label\" => \"name\", /
					content.should =~ /\"placeholder\" => \"name\"\}\}/
				}
			end

			it "should generate model with overwritten sample_name" do
				subject.should generate("app/models/adminpanel/product.rb") { |content|
					content.should =~ /def self.display_name\n      \"Product\"\n    end/
				}
			end
		end
	end
end
