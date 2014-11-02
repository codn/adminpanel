module Adminpanel
  class SectionsController < Adminpanel::ApplicationController
    def index
      @sections = Section.all
    end

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

      if @section.update(section_params)
        redirect_to section_path(@section), notice: 'La seccion se ha actualizado'
      else
        render 'edit'
      end
    end

    def show
      @section = Section.find(params[:id])
    end

    private
    def section_params
      params.require(:section).permit(
        :has_description,
        :description,
        :key,
        :page,
        :name,
        :max_files,
        :has_image,
        {
          sectionfiles_attributes: [
            :id,
            :file,
            :_destroy
          ]
        }
      )
    end
  end
end
