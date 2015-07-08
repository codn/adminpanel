module Adminpanel
  class Analytic
    # include Adminpanel::Base

    def name
      'analytic'
    end

    def self.display_name
      I18n.t("model.Analytic")
    end

    def self.collection_name
      display_name
    end

    def self.icon
      "dashboard"
    end

    def self.has_route?(path)
      true
    end

  end
end
