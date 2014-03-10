require 'spec_helper'

describe "adminpanel rake task" do

  before :all do
    Rake.application.rake_require "tasks/adminpanel/adminpanel"
    Rake::Task.define_task(:environment)
  end

  describe "adminpanel:populate[20, product, name:name description:lorem price:number]" do

    let(:has_nil_attribute) { false }
    before do
      Rake.application.invoke_task "adminpanel:populate[20, product, name:name description:lorem price:number]"
    end


    it "should generate 20 product records" do
      Adminpanel::Product.all.count.should eq 20
    end

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

  describe "adminpanel:section[about, mission]" do
    before do
      Rake.application.invoke_task "adminpanel:section[about, mission]"
    end

    it "should create a section with name 'mission' and section 'about'" do
      (
        (Adminpanel::Section.last.name.should eq("Mission")) &&
        (Adminpanel::Section.last.page.should eq("about")) &&
        (Adminpanel::Section.last.key.should eq("mission")) &&
        (Adminpanel::Section.last.has_description.should be_true) &&
        (Adminpanel::Section.last.has_image.should be_false)
      )
    end
  end
end
