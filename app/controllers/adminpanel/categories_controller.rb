module Adminpanel
  class CategoriesController < ApplicationController
    skip_before_action :set_resource_collection

    def index
      @categories = Category.all
    end

    def new
      @resource_instance = @model.new
      set_collections
      respond_to do |format|
        format.html { render "shared/new" }
        format.js { render }
      end
    end

    def create
      merge_params
      @resource_instance = @model.new(send(whitelisted_params))
      respond_to do |format|
        if @resource_instance.save
          format.html { redirect_to categories_path, flash: { success: I18n.t('action.save_success') } }
          format.js do
            if params[:currentcontroller].to_s == 'adminpanel/categories'
              render 'create', :locals => { :category => resource }
            elsif params[:belongs_request].present?
              render 'shared/create_belongs_to', locals: { resource: @resource_instance }
            else
              render 'shared/create_has_many', locals: { resource: @resource_instance }
            end
          end
        else
          set_collections
          format.html { render 'shared/new' }
          format.js { render 'new' }
        end
      end
    end

    def destroy
      @resource_instance.destroy
      redirect_to categories_path
    end

    private
      def category_params
        params.require(:category).permit(:name, :model)
        # permitted.permit(:currentcontroller)
        # params.require(:currentcontroller)

      end
  end
end
