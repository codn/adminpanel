require 'spec_helper'

describe "adminpanel:initialize" do
  context "with no arguments or options" do
    it "should generate a migration" do
      subject.should generate("db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_adminpanel_tables.rb")
    end
  end
end