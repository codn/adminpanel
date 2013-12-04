require 'spec_helper'

describe Adminpanel::Image do
  before do
    @image = Adminpanel::Image.new(
      :file => "Test file"
      )
  end

  subject { @image }

  it { should respond_to(:file) }
  it { should respond_to(:foreign_key) }
  it { should respond_to(:model) }

  describe "when file is not present" do
    before {@image.file = " "}
    it {should_not be_valid}
  end

  describe "when model is not present" do
    before {@image.model = " "}
    it {should_not be_valid}
  end
end