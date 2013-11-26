module Adminpanel
  class UsersController < Adminpanel::ApplicationController
    # GET /admin/users
    # GET /admin/users.json
    def index
      @admin_users = User.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @admin_users }
      end
    end

    # GET /admin/users/1
    # GET /admin/users/1.json
    def show
      @admin_user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @admin_user }
      end
    end

    # GET /admin/users/new
    # GET /admin/users/new.json
    def new
      @admin_user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @admin_user }
      end
    end

    # GET /admin/users/1/edit
    def edit
      @admin_user = User.find(params[:id])
    end

    # POST /admin/users
    # POST /admin/users.json
    def create
      @admin_user = User.new(params[:admin_user])

      respond_to do |format|
        if @admin_user.save
          format.html { redirect_to @admin_user, :notice => 'Se ha creado con exito.' }
          format.json { render :json => @admin_user, :status => :created, :location => @admin_user }
        else
          format.html { render :action => "new" }
          format.json { render :json => @admin_user.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /admin/users/1
    # PUT /admin/users/1.json
    def update
      @admin_user = User.find(params[:id])

      respond_to do |format|
        if @admin_user.update_attributes(params[:admin_user])
          format.html { redirect_to @admin_user, :notice => 'Se ha actualizado con exito.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @admin_user.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/users/1
    # DELETE /admin/users/1.json
    def destroy
      @admin_user = User.find(params[:id])
      @admin_user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_url }
        format.json { head :no_content }
      end
    end
  end
end
