module Adminpanel
  module GalleryzableActions
    extend ActiveSupport::Concern

    def move_better
      resource = @model.find(params[:id])
      resource.move_to_better_position
      respond

    end

    def move_worst
      resource = @model.find(params[:id])
      resource.move_to_worst_position
      respond
    end

  private
    def respond
      respond_to do |format|
        format.js do
          render 'adminpanel/shared/gallery_entries', :locals => {
            :collection => @model.where(
              @model.relation_field.to_sym => resource.send(@model.relation_field)
            )
          }
        end
      end
    end
  end
end
