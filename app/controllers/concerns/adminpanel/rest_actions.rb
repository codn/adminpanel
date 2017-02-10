module Adminpanel
  module RestActions
    extend ActiveSupport::Concern
    included do
      before_action :set_resource_instance, only: [
                                              :show,
                                              :edit,
                                              :update,
                                              :destroy,
                                              :move_to_position,
                                              :fb_choose_page,
                                              :fb_save_token,
                                              :fb_publish
                                            ]
      before_action :set_resource_collection, only: [:index, :destroy]
    end

    def index
      if stale?(etag: @collection, public: true, template: false)
        render 'adminpanel/templates/index'
      end
    end

    def show
      if stale?(etag: @resource_instance, public: true, template: false)
        render 'adminpanel/templates/show'
      end
    end

    def new
      @resource_instance = @model.new
      respond_to do |format|
        format.html do
          render 'adminpanel/templates/new'
        end
        format.js do
          render 'adminpanel/templates/new'
        end
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
              # we are in other controller as a belongs_to, add option to select
              render 'adminpanel/templates/option_for_select'
            else
              # we are in other controller as a has_many, add checkbox
              render 'adminpanel/templates/checkbox'
            end
          end
        else
          format.html do
            render 'adminpanel/templates/new'
          end
          format.js do
            render 'adminpanel/templates/new'
          end
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
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.js { render('adminpanel/templates/destroy') }
      end
    end

    private

    def set_resource_collection
      @collection = @model.all
    end

    def set_resource_instance
      if @model.respond_to? :friendly
        @resource_instance ||= @model.friendly.find(params[:id])
      else
        @resource_instance ||= @model.find(params[:id])
      end
    end

    def merge_params
      params.merge({model:           params[:model]})           if params[:model].present?
      params.merge({model_name:      params[:model_name]})      if params[:model_name].present?
      params.merge({belongs_request: params[:belongs_request]}) if params[:belongs_request].present?
    end

    def whitelisted_params
      resource = controller_name.singularize.to_sym
      "#{resource}_params"
    end
  end
end
