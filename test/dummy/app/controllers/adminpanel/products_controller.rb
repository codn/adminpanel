module Adminpanel
  class ProductsController < Adminpanel::ApplicationController

    private
    def product_params
      params.require(:product).permit(
        :price,
        :name,
        :category_ids,
        :description,
        :photos_attributes => [:product_id, :file]
      )
    end

  end
end
