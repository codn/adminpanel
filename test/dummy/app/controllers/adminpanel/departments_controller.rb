module Adminpanel
  class DepartmentsController < Adminpanel::ApplicationController

    private
      def department_params
        params.require(:department).permit(
          :category_id,
          :product_ids,
          :name
        )
      end
  end
end
