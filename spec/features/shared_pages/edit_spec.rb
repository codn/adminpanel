require 'spec_helper'

describe 'Shared edit', js: true do
  subject { page }

  let(:user) { get_user }

  before do
    Adminpanel::User.delete_all
    visit adminpanel.signin_path
    valid_signin_as_admin(user)
  end

  after do
    Adminpanel::User.delete_all
  end

  context 'edit' do
    let!(:product) { FactoryGirl.create(:product) }
    let!(:category){ FactoryGirl.create(:category) }

    before do
      product.category_ids = [category.id]
      visit adminpanel.edit_product_path(product)
    end

    it { should have_link('Agregar Categoria') }

    it { should have_content('Test Category') }

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
end
