require 'spec_helper'

describe 'Shared show', js: true do
  subject { page }

  let(:user) { get_user }
  let!(:category){ FactoryGirl.create(:category) }
  let!(:product) { FactoryGirl.create(:product) }
  let!(:photo) { FactoryGirl.create(:photo) }

  before do
    Adminpanel::User.delete_all
    visit adminpanel.signin_path
    valid_signin_as_admin(user)
    product.category_ids = [category.id]
    photo.product_id = product.id
    visit adminpanel.product_path(product)
  end

  after do
    Adminpanel::User.delete_all
  end

  it { page.should have_selector('div', text: product.name) }
  it { page.should have_selector('div', text: product.price) }
  it { page.should have_selector('div', text: product.description) }
  it { should have_content("#{I18n.t("gallery.container")}: #{Adminpanel::Product.display_name}")}
  it { should have_content("#{category.name}")}
  it { should have_link('i', adminpanel.edit_product_path(product)) }
end
