module Adminpanel
  module SortableActions
    extend ActiveSupport::Concern

    def move_to_better
      resource = @model.find(params[:id])
      resource.move_to_better_position
      update_index_table

    end

    def move_to_worst
      resource = @model.find(params[:id])
      resource.move_to_worst_position
      update_index_table
    end

  protected
    def update_index_table
      respond_to do |format|
        format.js do
          render 'adminpanel/templates/index_records', locals: {
            collection: @model.all
          }
        end
      end
    end
  end
end
