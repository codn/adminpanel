module Adminpanel
  class SectionsController < Adminpanel::ApplicationController
    def index
      @sections = Section.all
    end

    def edit
      @section = Section.find(params[:id])
    end

    def update
      @section = Section.find(params[:id])

      if @section.update(section_params)
        redirect_to section_path(@section), notice: 'La seccion se ha actualizado'
      else
        render 'edit'
      end
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
        sectionfile_ids: []
      )
    end
  end
end
