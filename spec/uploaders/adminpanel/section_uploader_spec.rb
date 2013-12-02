require 'spec_helper'
require 'support/active_record'
require 'carrierwave/test/matchers'

describe Adminpanel::SectionUploader do
  include CarrierWave::Test::Matchers

  before do
    Adminpanel::SectionUploader.enable_processing = true
    @section = Adminpanel::Section.new(
      :file => "test.jpg",
      :description => nil,
      :has_image => true,
      :key => "section_key",
      :name => "identifier name",
      :has_description => false
      )
    @section_uploader = Adminpanel::SectionUploader.new(@section, :file)
    @section_uploader.store!(File.open(Rails.root + "app/assets/images/test.jpg"))
  end

  after do
    Adminpanel::SectionUploader.enable_processing = false
    @section_uploader.remove!
  end

  context 'the section.thumb version' do
    it "should scale down a landscape image to be exactly 460 by 355 pixels" do
      @section_uploader.thumb.should be_no_larger_than(460, 355)
    end
  end\
end