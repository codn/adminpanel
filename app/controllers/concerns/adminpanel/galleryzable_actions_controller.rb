module Adminpanel
  module GalleryzableActionsController
    extend ActiveSupport::Concern
    
    def move_better
      respond_to do |format|
        format.js do
          resource = @model.find(params[:id])
          resource.move_to_better_position
          render 'shared/gallery_entries', :locals => {
            :collection => @model.where(
              @model.relation_field.to_sym => resource.send(@model.relation_field)
            )
          }
        end
      end
    end

    def move_worst
      respond_to do |format|
        format.js do
          resource = @model.find(params[:id])
          resource.move_to_worst_position
          render 'shared/gallery_entries', :locals => {
            :collection => @model.where(
              @model.relation_field.to_sym => resource.send(@model.relation_field)
              )
          }
        end
      end
    end
  end
end
