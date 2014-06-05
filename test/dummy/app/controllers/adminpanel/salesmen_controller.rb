module Adminpanel
  class SalesmenController < Adminpanel::ApplicationController

    private
      def salesman_params
        params.require(:salesman).permit(:name, :product_id)
      end
  end
end
