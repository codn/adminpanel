module Adminpanel
  module RestActions
    extend ActiveSupport::Concern
    included do
      before_action :set_resource_instance, only:[:show, :edit, :update, :destroy]
      before_action :set_resource_collection, only:[:index, :destroy]
    end

    def index
      render 'shared/index'
    end

    def show
      render 'shared/show'
    end

    def new
      @resource_instance = @model.new
      set_collections
      respond_to do |format|
        format.html { render 'shared/new' }
        format.js { render 'shared/new', locals: { resource: @resource_instance } }
      end
    end

    def create
      merge_params
      @resource_instance = @model.new(send(whitelisted_params))
      respond_to do |format|
        if @resource_instance.save
          format.html { redirect_to @resource_instance, flash: { success: I18n.t('action.save_success') } }
          format.js do
            if params[:belongs_request]
              render 'shared/create_belongs_to', locals: { resource: @resource_instance }
            else
              render 'shared/create_has_many', locals: { resource: @resource_instance }
            end
          end
        else
          set_collections
          format.html { render 'shared/new' }
          format.js do
            render 'shared/new', locals: { resource: @resource_instance }
          end
        end
      end
    end


    def edit
      set_collections
      render 'shared/edit'
    end

    def update
      if @resource_instance.update(send(whitelisted_params))
        flash[:success] = I18n.t('action.save_success')
        redirect_to @resource_instance
      else
        set_collections
        render 'shared/edit'
      end
    end

    def destroy
      @resource_instance.destroy
      render 'shared/index'
    end

    private

    def set_collections
      @collections = {}
      set_belongs_to_collections
      set_has_many_collections
    end

    def set_belongs_to_collections
      @model.relationships_of('belongs_to').each do |class_variable|
        set_relationship(class_variable)
      end
    end

    def set_has_many_collections
      @model.relationships_of('has_many').each do |class_variable|
        set_relationship(class_variable)
      end
    end

    def set_relationship(class_variable)
      if class_variable.respond_to?("of_model")
        @collections.merge!({"#{class_variable}" => class_variable.of_model(@model.display_name)})
      else
        @collections.merge!({"#{class_variable}" => class_variable.all})
      end
    end

    def merge_params
      params.merge({:model => params[:model]}) if params[:model].present?
      params.merge({:model_name => params[:model_name]}) if params[:model_name].present?
      params.merge({:belongs_request => params[:belongs_request]}) if params[:belongs_request].present?
      params.merge({:currentcontroller => params[:currentcontroller]}) if params[:currentcontroller].present?
    end

    def whitelisted_params
      resource = controller_name.singularize.to_sym
      "#{resource}_params"
    end

    def set_resource_instance
      @resource_instance = @model.find(params[:id])
    end

    def set_resource_collection
      @collection = @model.all
    end
  end
end
