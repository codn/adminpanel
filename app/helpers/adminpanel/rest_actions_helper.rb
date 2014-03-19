module Adminpanel
	module RestActionsHelper
		def index
      index! do |format|
        format.html { render "shared/index" }
      end
		end

		def show
			show! do |format|
				format.html { render "shared/show" }
			end
		end

		def new
			set_collections
      new! do |format|
        format.html { render "shared/new" }
      end
		end

		def create
      create! do |success, failure|
        success.html do
        	flash.now[:success] = I18n.t("action.save_success")
          render "shared/index"
        end
        failure.html do
					set_collections
        	render "shared/new"
				end
      end
		end

		def edit
      edit! do |format|
        format.html do
        	set_collections
        	render "shared/edit"
        end
      end
		end

		def update
      update! do |success, failure|
        success.html do
        	flash.now[:success] = I18n.t("action.save_success")
        	render "shared/index"
        end
        failure.html do
        	set_collections
        	render "shared/edit"
        end
      end
		end

		def destroy
			destroy! do |format|
				format.html { render "shared/index" }
			end
		end

	private

		def set_collections
			@collections = {}
			set_belongs_to_collections
			@model.has_many_relationships.each do |class_variable|
				@collections.merge!({"#{class_variable}" => class_variable.find(:all)})
			end
		end

		def set_belongs_to_collections
			@model.belongs_to_relationships.each do |class_variable|
				if class_variable.respond_to?("of_model")
					@collections.merge!({"#{class_variable}" => class_variable.of_model(@model.display_name)})
				else
					@collections.merge!({"#{class_variable}" => class_variable.find(:all)})
				end
			end
		end
	end
end
