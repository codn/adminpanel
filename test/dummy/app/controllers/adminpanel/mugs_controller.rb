module Adminpanel
  class MugsController < Adminpanel::ApplicationController

    private
      def mug_params
        params.require(:mug).permit(:name, :number)
      end
  end
end
