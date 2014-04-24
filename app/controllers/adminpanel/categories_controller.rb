module Adminpanel
  class CategoriesController < ApplicationController
    load_and_authorize_resource

    def index
      @categories = Category.all
    end

    def new
      set_collections
      new! do |format|
        format.html { render "shared/new" }
        format.js do
          render
        end
      end
    end


    def create
      params.merge({:model_name => params[:model_name]}) if params[:model_name].present?
      params.merge({:model => params[:model]}) if params[:model].present?
      params.merge({:currentcontroller => params[:currentcontroller]}) if params[:currentcontroller].present?
      params.merge({:belongs_request => params[:belongs_request]}) if params[:belongs_request].present?

      create! do |success, failure|
        success.html do
          flash[:success] = I18n.t("action.save_success")
          redirect_to categories_path
        end
        failure.html do
          set_collections
          render 'shared/new'
        end
        success.js do
          if params[:currentcontroller].to_s == 'adminpanel/categories'
            render 'create', :locals => {:category => resource}
          elsif params[:belongs_request].present?
            render 'shared/create_belongs_to'
          else
            render 'shared/create_has_many'
          end
        end
        failure.js do
          set_collections
          render "new"

        end
      end
    end

    def edit
      edit! do |format|
        format.html do
          set_collections
          render "shared/edit"
        end
      end
    end

    def update
      update! do |success, failure|
        success.html do
          flash[:success] = I18n.t("action.save_success")
          # render "shared/index"
          redirect_to categories_path
        end
        failure.html do
          set_collections
          render "shared/edit"
        end
      end
    end

    def destroy
      destroy! do |format|
        format.html do
          redirect_to categories_path
        end
      end
    end

    private
      def category_params
        params.require(:category).permit(:name, :model)
        # permitted.permit(:currentcontroller)
        # params.require(:currentcontroller)

      end
  end
end
