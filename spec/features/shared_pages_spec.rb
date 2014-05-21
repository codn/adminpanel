require 'spec_helper'

describe 'Shared pages', js: true do
	subject { page }


	let(:user) { get_user }
	let!(:product) { FactoryGirl.create(:product) }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:photo) { FactoryGirl.create(:photo) }
	let!(:mug) { FactoryGirl.create(:mug) }

	before do
		Adminpanel::User.delete_all
		visit adminpanel.signin_path
		valid_signin_as_admin(user)
	end

	after do
		Adminpanel::User.delete_all
	end

	context 'mugs#index excluding every rest action with configurtions but index' do
		before do
			visit adminpanel.mugs_path
		end

		it 'should not have create mug button' do
			should_not have_link('a', href:'/adminpanel/tazas/new')
		end
		it 'should not have show or destroy button' do
			should_not have_link('a', href:'/adminpanel/tazas/1')
		end
		it 'should not have edit button' do
			should_not have_link('a', href:'/adminpanel/tazas/1/edit')
		end
	end


	context 'index' do
		before do
			visit adminpanel.products_path
		end

		it { should have_link(Adminpanel::Product.display_name, adminpanel.new_product_path)}
		it { should have_link('i', adminpanel.product_path(product)) }
		it { should have_link('i', adminpanel.edit_product_path(product)) }
	end

	context 'new' do
		before do
			visit adminpanel.new_product_path
		end

		describe 'when submtting with invalid information' do
			before do
				click_button('Agregar Producto')
			end

			it { should have_title("#{I18n.t('action.create')} #{Adminpanel::Product.display_name}") }

			it 'should have validation alert' do
				should have_content('Producto no pudo guardarse debido a')
			end
		end

		describe 'when submitting with valid information' do
			before do
				fill_in 'product_name', :with => 'product name'
				fill_in 'product_price', :with => '855.5'
				page.execute_script(
					%Q(
						$('#product_description').data('wysihtml5').editor.setValue('que pepsi');
					)
				) # to fill the wysiwyg editor

				click_button('Agregar Producto')
			end

			it { should have_content(I18n.t("action.save_success"))}
			it { should have_title('Ver Producto')}
		end

		describe 'when clicking create remote category link (has_many through)' do
			before do
				click_link('Agregar Categoria')
			end

			it 'the modal should have the correct title' do
				find('#modal-title').text.should == 'Agregar Categoria'
			end

			it 'should show the cateogry form in a modal' do
			  should have_content('Agregar Categoria')
			end

			context 'when submitting the remote (checkboxes) category form' do
				describe 'with valid information' do
					before do
						fill_in 'category_name', with: 'remote category'
						click_button 'Agregar Categoria'
					end

					it 'should have the created category in the checkboxes options' do
						should have_content 'remote category'
					end
				end

				describe 'with invalid information' do
					before do
						click_button 'Agregar Categoria'
					end

					it 'should have the errors' do
						should have_content I18n.t('errors', model: 'Categoria', count: 1)
					end
				end
			end
		end
	end

	context 'new salesman' do
		before do
			visit adminpanel.new_salesman_path
		end

		describe 'when clicking the create remote product link (belongs_to)' do
			before do
				click_link 'Agregar Producto'
			end

			it 'the modal should have the correct title' do
				find('#modal-title').text.should == 'Agregar Producto'
			end

			context 'submitting the remote (select) product form' do
				describe 'with valid information' do
					before do
						fill_in 'product_name', with: 'remote product'
						fill_in 'product_description', with: 'remote description lorem'
						fill_in 'product_price', with: '12.3'
						click_button 'Agregar Producto'
					end

					it 'should have the created product in the select options' do
						should have_xpath "//option[contains(text(), 'remote product' )]"
					end
				end

				describe 'with invalid information' do
					before do
						click_button 'Agregar Producto'
					end

					it 'should have the errors' do
						should have_content I18n.t('errors', model: 'Producto', count: 3)
					end
				end
			end
		end
	end

	context 'edit' do

		before do
			product.category_ids = [category.id]
			visit adminpanel.edit_product_path(product)
		end

		it { should have_title(I18n.t('action.update') + " " + Adminpanel::Product.display_name) }

		describe "with invalid information" do
			before do
				fill_in "product_name", with: ""
				fill_in "product_price", with: ""
				click_button('Guardar Product')
			end

			it 'should have an error alert' do
				should have_content('Producto no pudo guardarse debido a')
			end

			it { should have_title(I18n.t('action.update') + " " + Adminpanel::Product.display_name) }
		end

	end

	context 'show' do

		before do
			photo.product_id = product.id
			visit adminpanel.product_path(product)
		end

		it { page.should have_selector('div', text: product.name) }
		it { page.should have_selector('div', text: product.price) }
		it { page.should have_selector('div', text: product.description) }
		it { should have_content("#{I18n.t("gallery.container")}: #{Adminpanel::Product.display_name}")}
		it { should have_link('i', adminpanel.edit_product_path(product)) }
	end
end
