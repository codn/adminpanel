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
                failure.html { render "shared/new"}
            end
		end

		def edit
            edit! do |format|
                format.html { render "shared/edit" }
            end
		end

		def update
            update! do |success, failure|
                success.html do 
                	flash.now[:success] = I18n.t("action.save_success")
                	render "shared/index" 
                end
                failure.html { render "shared/edit" }
            end
		end

		def destroy
			destroy! do |format|
				format.html { render "shared/index" }
			end
		end
	end
end