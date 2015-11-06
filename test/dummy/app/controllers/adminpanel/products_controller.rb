module Adminpanel
  class ProductsController < Adminpanel::ApplicationController

    private
    def product_params
      params.require(:product).permit(
        :price,
        :name,
        :category_ids,
        :description,
        photo_ids: []
      )
    end

  end
end
