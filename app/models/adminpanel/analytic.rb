module Adminpanel
  class Analytic #< ActiveRecord::Base

    def self.display_name
      "Google Analytics"
    end

    def self.display_icon
      'icon-dashboard'
    end
  end
end
