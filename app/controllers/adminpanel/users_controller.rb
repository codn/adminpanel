module Adminpanel
  class UsersController < Adminpanel::ApplicationController
    # GET /admin/users
    # GET /admin/users.json
    # def index
    #   @users = User.all
    #
    #   respond_to do |format|
    #     format.html # index.html.erb
    #     format.json { render :json => @users }
    #   end
    # end

    # GET /admin/users/1
    # GET /admin/users/1.json
    # def show
    #   @user = User.find(params[:id])
    #
    #   respond_to do |format|
    #     format.html # show.html.erb
    #     format.json { render :json => @user }
    #   end
    # end
    #
    # # GET /admin/users/new
    # # GET /admin/users/new.json
    # def new
    #   @user = User.new
    #
    #   respond_to do |format|
    #     format.html # new.html.erb
    #     format.json { render :json => @user }
    #   end
    # end

    # GET /admin/users/1/edit
    # def edit
    #   @user = User.find(params[:id])
    # end
    #
    # # POST /admin/users
    # # POST /admin/users.json
    # def create
    #   @user = User.new(params[:user])
    #
    #   respond_to do |format|
    #     if @user.save
    #       format.html { redirect_to @user, :notice => t("user.success") }
    #       format.json { render :json => @user, :status => :created, :location => @user }
    #     else
    #       format.html { render :action => "new" }
    #       format.json { render :json => @user.errors, :status => :unprocessable_entity }
    #     end
    #   end
    # end

    # PUT /admin/users/1
    # PUT /admin/users/1.json
    # def update
    #   @user = User.find(params[:id])
    #
    #   respond_to do |format|
    #     if @user.update_attributes(params[:user])
    #       format.html { redirect_to @user, :notice => 'Se ha actualizado con exito.' }
    #       format.json { head :no_content }
    #     else
    #       format.html { render :action => "edit" }
    #       format.json { render :json => @user.errors, :status => :unprocessable_entity }
    #     end
    #   end
    # end

    # DELETE /admin/users/1
    # DELETE /admin/users/1.json
    # def destroy
    #   @user = User.find(params[:id])
    #   @user.destroy
    #
    #   respond_to do |format|
    #     format.html { redirect_to users_url }
    #     format.json { head :no_content }
    #   end
    # end
  end
end
