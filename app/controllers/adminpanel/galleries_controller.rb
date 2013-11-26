module Adminpanel
  class GalleriesController < Adminpanel::ApplicationController
    def index
      @galleries = Gallery.all
    end

    def show
      @gallery = Gallery.find(params[:id])
    end

    def edit
      @gallery = Gallery.find(params[:id])
    end

    def create
      @gallery = Gallery.new(params[:gallery])

      if @gallery.save
        redirect_to admin_gallery_path(@gallery), :notice => "La imagen ha sido creada"
      else
        render 'new'
      end
    end

    def destroy
      @gallery = Gallery.find(params[:id])
      @gallery.destroy

      redirect_to admin_galleries_path, :notice => "La imagen ha sido eliminada"
    end

    def update
      @gallery = Gallery.find(params[:id])
      if @gallery.update_attributes(params[:gallery])
        redirect_to admin_gallery_path(@gallery)
      else
        render 'edit'
      end
    end

    def new
      @gallery = Gallery.new
    end
  end
end