require 'spec_helper'

describe "adminpanel namespace task" do

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
      Adminpanel::Product.count.should eq 20
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
end
