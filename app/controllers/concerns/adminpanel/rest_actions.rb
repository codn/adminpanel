module Adminpanel
  module RestActions
    extend ActiveSupport::Concern
    included do
      before_action :set_resource_instance, only: [
                                              :show,
                                              :edit,
                                              :update,
                                              :destroy,
                                              :fb_choose_page,
                                              :fb_save_token,
                                              :fb_publish,
                                              :twitter_publish,
                                              :move_to_better,
                                              :move_to_worst
                                            ]
      before_action :set_resource_collection,      only: [:index, :destroy]
      before_action :set_relationship_collections, only: [:new, :create, :edit, :update]
    end

    def index
      render 'adminpanel/templates/index' if stale?(etag: @collection, public: true)
    end

    def show
      render 'adminpanel/templates/show' if stale?(etag: @resource_instance, public: true)
    end

    def new
      @resource_instance = @model.new
      respond_to do |format|
        render_new(format)
      end
    end

    def create
      merge_params
      @resource_instance = @model.new(send(whitelisted_params))
      respond_to do |format|
        if @resource_instance.save
          format.html { redirect_to @resource_instance }
          format.js do
            # if format js, request is from another controller's form
            if params[:belongs_request]
              render 'adminpanel/templates/create_belongs_to', locals: { resource: @resource_instance }
            else
              render 'adminpanel/templates/create_has_many', locals: { resource: @resource_instance }
            end
          end
        else
          render_new(format)
        end
      end
    end


    def edit
      render 'adminpanel/templates/edit'
    end

    def update
      if @resource_instance.update(send(whitelisted_params))
        redirect_to @resource_instance
      else
        render 'adminpanel/templates/edit'
      end
    end

    def destroy
      @resource_instance.destroy
      redirect_to action: :index
    end

    private

    def set_relationship_collections
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
      params.merge({model:             params[:model]})             if params[:model].present?
      params.merge({model_name:        params[:model_name]})        if params[:model_name].present?
      params.merge({belongs_request:   params[:belongs_request]})   if params[:belongs_request].present?
      params.merge({currentcontroller: params[:currentcontroller]}) if params[:currentcontroller].present?
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

    def render_new format
      format.html do
        render 'adminpanel/templates/new'
      end
      format.js do
        render 'adminpanel/templates/new', locals: { resource: @resource_instance }
      end
    end
  end
end
