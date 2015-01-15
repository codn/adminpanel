module Adminpanel
  module GalleryzableActions
    extend ActiveSupport::Concern

    included do
      skip_authorize_resource :move_gallery_better, :move_gallery_worst
    end

    def move_gallery_better
      @resource_instance = @model.find(params[:id])
      @resource_instance.move_to_better_position
      respond
    end

    def move_gallery_worst
      @resource_instance = @model.find(params[:id])
      @resource_instance.move_to_worst_position
      respond
    end

  private
    def respond
      respond_to do |format|
        format.js do
          render 'adminpanel/templates/gallery_entries', locals: {
            collection: @model.ordered.where(
              @model.relation_field.to_sym => @resource_instance.send(@model.relation_field)
            )
          }
        end
      end
    end
  end
end
