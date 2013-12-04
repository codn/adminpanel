require 'spec_helper'
require 'support/active_record'
require 'carrierwave/test/matchers'

describe Adminpanel::GalleryUploader do
  include CarrierWave::Test::Matchers

  before do
    Adminpanel::GalleryUploader.enable_processing = true
    @gallery = Adminpanel::Gallery.new(:file => "test.jpg")
    @gallery_uploader = Adminpanel::GalleryUploader.new(@gallery, :file)
    @gallery_uploader.store!(File.open(Rails.root + "app/assets/images/hipster.jpg"))
  end

  after do
    Adminpanel::GalleryUploader.enable_processing = false
    @gallery_uploader.remove!
  end

  context 'the gallery.thumb version' do
    it "should scale down a landscape image to be exactly 200 by 200 pixels" do
      @gallery_uploader.thumb.should be_no_larger_than(200, 200)
    end
  end

  context 'the gallery.default version' do
    it "should scale down a landscape image to fit within 1024 by 450 pixels" do
      @gallery_uploader.should have_dimensions(1024, 450)
    end
  end
end