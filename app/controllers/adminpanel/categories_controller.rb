module Adminpanel
  class CategoriesController < ApplicationController
    skip_before_action :set_resource_collection

    def index
      @categories = Category.all
    end

    def new
      @resource_instance = @model.new
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
              render 'create', locals: { category: resource } # we are in categories controller
            elsif params[:belongs_request].present?
              render 'shared/create_belongs_to', locals: { resource: @resource_instance } # we are in other controller as a belongs_to, add option to select
            else
              render 'shared/create_has_many', locals: { resource: @resource_instance } # we are in other controller as a has_many, add checkbox
            end
          end
        else
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
      end
  end
end
