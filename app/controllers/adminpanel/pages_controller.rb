module Adminpanel
  class PagesController < Adminpanel::ApplicationController
    before_action :redefine_model

    def show
    end

    def edit
      params[:skip_breadcrumb] = true
      super
    end

    def update
      if @resource_instance.update(page_params)
        redirect_to page_path(@resource_instance)
      else
        params[:skip_breadcrumb] = true
        render 'adminpanel/templates/edit'
      end
    end

    private

      def redefine_model
        @model = @resource_instance.class
      end

      def page_params
        @model.whitelisted_attributes(params)
      end
  end
end
