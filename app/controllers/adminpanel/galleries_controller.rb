module Adminpanel
  class GalleriesController < Adminpanel::ApplicationController
    authorize_resource

    def index
      @galleries = Gallery.all
    end

    # def show
    #   @gallery = Gallery.find(params[:id])
    # end

    # def edit
    #   @gallery = Gallery.find(params[:id])
    # end

    def create
      @gallery = Gallery.new(params[:gallery])

      if @gallery.save
        redirect_to gallery_path(@gallery), :notice => t("gallery.success")
      else
        render 'new'
      end
    end

    def move_better
      @gallery = Gallery.find(params[:id])
      @gallery.move_to_better_position
      respond_to do |format|
        format.html do
          redirect_to galleries_path
        end
        format.js do
          @galleries = Gallery.all
          render :locals => { :galleries => @galleries }
        end
      end
    end

    def move_worst
      @gallery = Gallery.find(params[:id])
      @gallery.move_to_worst_position
      respond_to do |format|
        format.html do
          redirect_to galleries_path
        end
        format.js do
          @galleries = Gallery.all
          render :locals => { :galleries => @galleries }
        end
      end
    end

    def destroy
      @gallery = Gallery.find(params[:id])
      @gallery.destroy

      redirect_to galleries_path, :notice => t("gallery.deleted")
    end

    def update
      @gallery = Gallery.find(params[:id])
      if @gallery.update_attributes(params[:gallery])
        redirect_to gallery_path(@gallery)
      else
        render 'edit'
      end
    end

    # def new
    #   @gallery = Gallery.new
    # end

    private
    def gallery_params
      params.require(:gallery).permit(:file)

    end
  end
end
