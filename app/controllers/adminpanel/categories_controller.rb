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
          render :locals => {:resource => resource}
        end
      end
    end


    def create
      params.merge({:model_name => params[:model_name]}) if params[:model_name].present?
      params.merge({:model => params[:model]}) if params[:model].present?
      params.merge({:currentcontroller => params[:currentcontroller]}) if params[:currentcontroller].present?

      create! do |success, failure|
        success.html do
          flash[:success] = I18n.t("action.save_success")
          redirect_to categories_path
        end
        failure.html do
          set_collections
          render "shared/new"
        end
        success.js do
          if params[:currentcontroller] == 'adminpanel/categories'
            render 'create', :locals => {:category => resource}
          else
            render 'shared/create_has_many', :locals => {:resource => resource}
          end
        end
        failure.js do
          set_collections
          render "new", :locals => {:resource => resource }

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
  end
end
