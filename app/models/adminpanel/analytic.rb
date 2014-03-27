module Adminpanel
  class Analytic #< ActiveRecord::Base

    def self.display_name
      "Google Analytics"
    end

    def self.icon
      'icon-dashboard'
    end
  end
end
