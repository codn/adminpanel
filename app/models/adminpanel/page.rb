module Adminpanel
  class Page < ActiveRecord::Base
    include Adminpanel::Base


    def self.whitelisted_attributes(params)
      params.require(self.name.to_s.underscore.split('/').last).permit!
    end
  end
end
