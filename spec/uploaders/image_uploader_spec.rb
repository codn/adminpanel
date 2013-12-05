require 'spec_helper'
require 'support/active_record'
require 'carrierwave/test/matchers'

describe Adminpanel::ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    Adminpanel::ImageUploader.enable_processing = true
    @image = Adminpanel::Image.new(:file => "test.jpg")
    @image_uploader = Adminpanel::ImageUploader.new(@image, :file)
    @image_uploader.store!(File.open(Rails.root + "app/assets/images/test.jpg"))
  end

  after do
    Adminpanel::ImageUploader.enable_processing = false
    @image_uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 220 by 220 pixels" do
      @image_uploader.thumb.should be_no_larger_than(220, 220)
    end
  end

  context 'the porfolio version' do
    it "should scale down a landscape image to be exactly 468 by 312 pixels" do
      @image_uploader.portfolio.should be_no_larger_than(468, 312)
    end
  end
end