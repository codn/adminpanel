module Adminpanel
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all
    end

    def new
      set_collections
      new! do |format|
        format.html { render "shared/new" }
        format.js {render :locals => {:category => resource, :model => params[:model]}}
      end
    end


    def create
      create! do |success, failure|
        success.html do
          flash.now[:success] = I18n.t("action.save_success")
          # render "shared/index"
          redirect_to categories_path
        end
        failure.html do
          set_collections
          render "shared/new"
        end

        success.js do
           render :locals => {:category => resource }

        end
        failure.js do
          set_collections
          render "new", :locals => {:category => resource, :model => resource.model }, :formats => [:js]

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
          flash.now[:success] = I18n.t("action.save_success")
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
