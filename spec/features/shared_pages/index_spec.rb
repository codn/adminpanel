require 'spec_helper'

describe 'Shared index' do
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

  context 'mugs#index excluding every rest action with configurtions but index' do
    before do
      Adminpanel::Mug.create
      visit adminpanel.mugs_path
    end

    after do
      Adminpanel::Mug.delete_all
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
    let!(:product) { FactoryGirl.create(:product) }
    before do
      visit adminpanel.products_path
    end

    it { should have_link(Adminpanel::Product.display_name, adminpanel.new_product_path)}
    it { should have_link('i', adminpanel.product_path(product)) }
    it { should have_link('i', adminpanel.edit_product_path(product)) }
  end
end
