module Adminpanel
	class CategoriesController < Adminpanel::ApplicationController
		def index
			@categories = Category.all
		end

		def new
			@category = Category.new
		end

		def create
			@category = Category.new(params[:category])
			if @category.save
				redirect_to categories_path, :notice => t("category.success")
			else
				render "new"
			end
		end

		def edit
			@category = Category.find(params[:id])
		end

		def update
			@category = Category.find(params[:id])

			if @category.update_attributes(params[:category])
				redirect_to categories_path, :notice => "#{@category.name} ha sido actualizado con exito"
			else
				render "edit"
			end
		end

		def destroy
			@category = Category.find(params[:id])
			@category.destroy

			redirect_to categories_path
		end
	end
end