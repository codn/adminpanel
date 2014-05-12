module Adminpanel
  class Analytic #< ActiveRecord::Base
    include Adminpanel::Base

    def self.display_name
      I18n.t('analytics')
    end

    def self.icon
      'dashboard'
    end
  end
end
