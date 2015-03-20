module Adminpanel
  module SortableActions
    extend ActiveSupport::Concern

    def move_to_position
      if @model.respond_to? :friendly
        resource = @model.friendly.find(params[:id])
      else
        resource = @model.find(params[:id])
      end

      resource = @model.find(params[:id])

      resource.move_to_position(params[:position].to_i)
      render json: {status: :ok}
    end
  end
end
