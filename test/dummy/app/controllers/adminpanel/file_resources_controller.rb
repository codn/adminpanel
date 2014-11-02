module Adminpanel
  class FileResourcesController < Adminpanel::ApplicationController

    private
      def file_test_params
        params.require(:file_test).permit(
          { file_testfiles_attributes: [:id, :file, :_destroy] },
          :name
        )
      end
  end
end
