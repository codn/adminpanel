require 'spec_helper'
require 'generators/adminpanel/resource/resource_generator'

describe Adminpanel::Generators::ResourceGenerator do
	destination File.expand_path('../../dummy/tmp', __FILE__)

	 before do
    prepare_destination
    Rails::Generators.options[:rails][:orm] = :active_record
  end

	after do
		prepare_destination
	end

	describe 'with some arguments and option -g false' do

    before do
			run_generator %w(
				post
				name
				description:wysiwyg
				number:float
				-g=false
			)
		end

		it "shouldn't generate the gallery ", focus: true do
			file('app/models/adminpanel/postfile.rb').should_not exist
		end
	end

	describe 'with arguments %w(post name description:wysiwyg number:float
		quantity:integer date:datepicker)' do

    before do
			run_generator %w(
				post
				name
				description:wysiwyg
				number:float
				flag:boolean
				quantity:integer
				date:datepicker
			)
		end

    it 'should generate the posts migration' do
			migration_file('db/migrate/create_adminpanel_posts.rb').should be_a_migration
		end

		context 'the migration' do
			it 'should have the correct fields' do
				migration_file('db/migrate/create_adminpanel_posts.rb').should(
					contain(/t.string :name/) &&
					contain(/t.float :number/) &&
					contain(/t.boolean :flag/) &&
					contain(/t.integer :quantity/) &&
					contain(/t.string :date/) &&
					contain(/t.text :description/)
				)
			end
		end

		context 'the controller' do
			it 'should generate posts controller' do
				file('app/controllers/adminpanel/posts_controller.rb').should exist
			end

			it 'should have the params whitelisted' do
				file('app/controllers/adminpanel/posts_controller.rb').should(
					contain(/params.require(:post).permit/) &&
					contain(/:name/) &&
					contain(/:description/) &&
					contain(/:number/) &&
					contain(/:flag/) &&
					contain(/:quantity/) &&
					contain(/:date/) &&
					contain(/{ postfiles_attributes: \[:id, :file, :_destroy\] }/)
				)
			end
		end


		it 'should generate post model' do
			file('app/models/adminpanel/post.rb').should exist
		end

		context 'the model' do
			it 'should generate the model with correct values' do
				file('app/models/adminpanel/post.rb').should(
					contain(/include Adminpanel::Base/) &&
					contain(/mount_images :postfiles/) &&
					contain(/'photos' => \{/) &&
					contain(/'type' => 'adminpanel_file_field'/)
				)
			end

			it 'should have the description hash' do
				file('app/models/adminpanel/post.rb').should(
					contain(/'description' => \{/) &&
					contain(/'type' => 'wysiwyg_field',/) &&
					contain(/'name' => \{/) &&
					contain(/'type' => 'text_field',/) &&
					contain(/'number' => \{/) &&
					contain(/'type' => 'text_field',/) &&
					contain(/'flag' => \{/) &&
					contain(/'type' => 'boolean',/) &&
					contain(/'quantity' => \{/) &&
					contain(/'type' => 'number_field',/) &&
					contain(/'date' => \{/) &&
					contain(/'type' => 'datepicker_field',/) &&
					contain(/'postfiles' => \{/) &&
					contain(/'type' => 'adminpanel_file_field',/)
				)
			end
		end
	end

	describe 'with arguments categorizations
		category:belongs_to product:belongs_to' do

		before do
			run_generator %w(
				categorization
				category:belongs_to
				product:belongs_to
			)
		end

		it "shouldn't generate categorizations controller" do
			file('app/controllers/adminpanel/categorizations_controller').should_not exist
		end

		it 'should generate categorization model' do
			file('app/models/adminpanel/categorization.rb').should(
				contain(/belongs_to :product/) &&
				contain(/belongs_to :category/)
			)
		end
	end

	describe 'with arguments post name products:has_many' do
		before do
			run_generator %w(
				post
				name
				products:has_many
			)
		end

		it 'should generate the model with has_many :categorizations' do
			file('app/models/adminpanel/post.rb').should(
				contain(/# has_many :categorizations/) &&
				contain(/# has_many :products, :through => :categorizations/)
			)
		end
	end
end
