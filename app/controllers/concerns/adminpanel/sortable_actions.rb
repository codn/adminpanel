module Adminpanel
  module SortableActions
    extend ActiveSupport::Concern

    def move_to_position
      resource = @model.find(params[:id])

      resource.move_to_position(params[:position].to_i)
      render json: {status: :ok}
    end
  end
end
