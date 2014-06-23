module Adminpanel
  module RestActions

    def index
      index! do |format|
        format.html { render 'shared/index' }
        format.json { render json: collection }
      end
    end

    def show
      show! do |format|
        format.html { render 'shared/show' }
        format.json { render json: resource }
      end
    end

    def new
      set_collections
      new! do |format|
        format.html { render 'shared/new' }
        format.js { render 'shared/new', :locals => { :resource => resource }}
      end
    end

    def create
      merge_params
      create! do |success, failure|
        success.html do
          flash[:success] = I18n.t('action.save_success')
          redirect_to resource
        end
        failure.html do
          set_collections
          render 'shared/new'
        end
        success.js do
          if params[:belongs_request]
            render 'shared/create_belongs_to', :locals => { :resource => resource }
          else
            render 'shared/create_has_many', :locals => { :resource => resource }
          end
        end
        failure.js do
          set_collections
          render 'shared/new', :locals => {:resource => resource }
        end
        respond_to_json(success, failure)
      end
    end


    def edit
      edit! do |format|
        format.html do
          set_collections
          render 'shared/edit'
        end
      end
    end

    def update
      update! do |success, failure|
        success.html do
          flash.now[:success] = I18n.t('action.save_success')
          render 'shared/index'
        end
        failure.html do
          set_collections
          render 'shared/edit'
        end
        respond_to_json(success, failure)
      end
    end

    def destroy
      destroy! do |format|
        format.html { render 'shared/index' }
      end
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

    def respond_to_json(success, failure)
      success.json do
        render json: resource
      end
      failure.json do
        render json: resource
      end
    end

  end
end
