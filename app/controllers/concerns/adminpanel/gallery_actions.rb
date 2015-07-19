module Adminpanel
  module GalleryActions
    extend ActiveSupport::Concern

    def add_to_gallery
      image_class = params[:model].constantize
      image = image_class.new(file: params[:file])

      if image.save
        response = {
          class: image_class.to_controller_name,
          id: image.id
        }

        respond_to do |f|
          f.json{ render status: :ok, json: response.to_json }
        end
      end
    end

    def remove_image
      @image = params[:model].constantize.find(params[:id])
      @image.destroy

      respond_to do |f|
        f.json{ render status: :ok, json: @image.to_json }
      end
    end
  end
end
