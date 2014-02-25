module Adminpanel
  class Engine < ::Rails::Engine
    isolate_namespace Adminpanel
  end

  class << self
  	mattr_accessor :analytics_profile_id, :analytics_key_path, :analytics_key_filename
  	self.analytics_profile_id = nil
  	self.analytics_key_path = "config/analytics"
  	self.analytics_key_filename = nil
  end

  def self.setup(&block)
  	yield self  	
  end
end
