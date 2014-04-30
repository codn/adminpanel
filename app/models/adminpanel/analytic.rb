module Adminpanel
  class Analytic #< ActiveRecord::Base
    include Adminpanel::Base

    def self.display_name
      "Google Analytics"
    end

    def self.icon
      'dashboard'
    end
  end
end
