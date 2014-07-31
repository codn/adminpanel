module Adminpanel
  class SectionsController < Adminpanel::ApplicationController
    # def new
    #   @section = Section.new
    #   authorize! :create, @section
    # end

    def edit
      @section = Section.find(params[:id])
      # respond_to do |format|
        # format.html
        # format.json {render :json => {:section => @section }}
      # end
    end

    def update
      @section = Section.find(params[:id])

      if @section.update_attributes(params[:section])
        redirect_to section_path(@section), :notice => 'La seccion se ha actualizado'
      else
        render 'edit'
      end
    end

    def show
      @section = Section.find(params[:id])
    end

    # def destroy
    #   @section = Section.find(params[:id])
    #   @section.destroy

    #   redirect_to sections_path
    # end

    def index
      @sections = Section.all
    end

    private
    def section_params
      params.require(:section).permit(
        :has_description,
        :description,
        :key,
        :page,
        :name,
        :has_image,
        { images_attributes: [:id, :file, :_destroy] }
      )
    end
  end
end
