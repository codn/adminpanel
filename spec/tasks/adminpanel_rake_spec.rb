require 'spec_helper'


describe 'adminpanel rake task' do

  before :all do
    Adminpanel::Section.delete_all
    Rake.application.rake_require 'tasks/adminpanel/adminpanel'
    Rake::Task.define_task(:environment)
  end

  describe 'adminpanel:populate[10, product, name:name description:lorem price:small_lorem]' do

    let(:has_nil_attribute) { false }
    before do
      Rake.application.invoke_task "adminpanel:populate[10, product, name:name description:lorem price:number]"
    end


    # it "should generate 10 product records" do
    #   Adminpanel::Product.find(:all).count.should eq 10
    # end

    it "attributes shouldn't be nil" do
      Adminpanel::Product.all.each do |product|
        if (product.name.nil? || product.description.nil? || product.price.nil? ||
          product.name == "" || product.description == "" || product.price == "")
          has_nil_attribute = true
        end
      end
      has_nil_attribute.should eq false
    end
  end

  describe 'adminpanel:section[mission, about]' do
    before do
      Rake.application.invoke_task "adminpanel:section[mission, about]"
    end

    it "should create a section with name 'mission' and section 'about'" do
      (
        (Adminpanel::Section.last.name.should eq("Mission")) &&
        (Adminpanel::Section.last.page.should eq("about")) &&
        (Adminpanel::Section.last.key.should eq("mission")) &&
        (Adminpanel::Section.last.has_description.should be_false) &&
        (Adminpanel::Section.last.has_image.should be_false)
      )
    end
  end

  describe 'adminpanel:user' do
    before do
      Rake.application.invoke_task 'adminpanel:user'
    end
    it 'should create webmaster@codn user' do
      Adminpanel::User.last.email.should eq('webmaster@codn.com')
    end
  end
end
