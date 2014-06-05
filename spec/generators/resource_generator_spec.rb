    # it 'should generate the posts migration' do
		# 	migration_file('db/migrate/create_adminpanel_posts.rb').should be_a_migration
		# end
		#
		# context 'the migration' do
		# 	it 'should have the correct fields' do
		# 		migration_file('db/migrate/create_adminpanel_posts.rb').should(
		# 			contain(/t.string :name/) &&
		# 			contain(/t.float :number/) &&
		# 			contain(/t.boolean :flag/) &&
		# 			contain(/t.integer :quantity/) &&
		# 			contain(/t.string :date/) &&
		# 			contain(/t.text :description/)
		# 		)
		# 	end
		# end

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
