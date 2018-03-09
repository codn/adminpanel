module Adminpanel
  class CategoriesController < Adminpanel::ApplicationController

    private
      def category_params
        params.require(:category).permit(
          :mug_ids,
          :product_ids,
          :name
        )
      end
  end
end
