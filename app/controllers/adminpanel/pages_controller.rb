module Adminpanel
  class PagesController < Adminpanel::ApplicationController
    after_action :redefine_model

    def redefine_model
      @model = @resource_instance.model
    end
  end
end
