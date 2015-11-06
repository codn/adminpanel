module Adminpanel
  module FacebookActions
    extend ActiveSupport::Concern

    included do
      before_action :set_fb_auths_count, only: [:index, :create, :update, :destroy, :show]
    end

    def fb_choose_page
      access_token = Koala::Facebook::OAuth.new(
        Adminpanel.fb_app_id,
        Adminpanel.fb_app_secret,
        url_for({
          controller: params[:controller],
          action: :fb_choose_page,
          id: @resource_instance,
          host: request.host
        })
      ).get_access_token(params[:code])
      user = Koala::Facebook::API.new(access_token)
      @pages = user.get_connections('me', 'accounts')
      @name = user.get_object('me')['name']
      @pages << { 'name' => @name, 'access_token' => access_token } # to permit posts on own wall
      render 'adminpanel/templates/fb_choose_page'
    end

    def fb_save_token
      page_selected = Koala::Facebook::API.new(
        params[model_name][:fb_page_access_key]
      )
      update_fb_auth(page_selected.get_object('me')['name'])
      flash[:success] = I18n.t('fb.saved_token')
      Rails.cache.clear
      redirect_to @resource_instance
    end

    def fb_publish
      authorize! :publish, @resource_instance

      page_graph = Koala::Facebook::API.new(Auth.find_by_key('facebook').value)
      options = {
        link: @resource_instance.share_link,
        name: @resource_instance.name
      }
      options.merge!({ picture: @resource_instance.share_picture }) if @resource_instance.share_picture
      page_graph.put_wall_post(
        params[model_name][:fb_message],
        options
      )
      flash[:success] = I18n.t('fb.posted', user: page_graph.get_object('me')['name'])
      redirect_to @resource_instance
    end

  private
    def set_fb_auths_count
      @fb_auths_count ||= Auth.find_by_key('facebook')
    end

    # Creates or updates the Facebook Auth token.
    def update_fb_auth(account_selected_name)
      auth = Auth.find_by(key: 'facebook', name: account_selected_name)
      if auth.nil?
        Auth.create(
          key: 'facebook',
          name: account_selected_name,
          value: params[model_name][:fb_page_access_key]
        )
      else
        #only support 1 fb account
        auth.update_attribute(:value, params[model_name][:fb_page_access_key])
      end
    end

    # Extracts the name of the model
    # @return Name of the model [String]
    def model_name
      @model.name.demodulize.downcase # ex: posts
    end
  end
end
