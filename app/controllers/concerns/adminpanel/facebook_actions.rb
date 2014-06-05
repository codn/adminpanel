module Adminpanel
  module FacebookActions
    extend ActiveSupport::Concern

    included do
      before_filter :set_auths_count
    end

    def fb_choose_page
      access_token = Koala::Facebook::OAuth.new(
        Adminpanel.fb_app_id,
        Adminpanel.fb_app_secret,
        url_for({
          controller: params[:controller],
          action: :fb_choose_page,
          id: resource,
          host: request.host
        })
      ).get_access_token(params[:code])
      user = Koala::Facebook::API.new(access_token)
      @pages = user.get_connections('me', 'accounts')
      user_object = user.get_object('me')
      @name = user_object['name']
      @pages << { 'name' => @name, 'access_token' => access_token } # to permit posts on own wall
      render 'shared/fb_choose_page'
    end

    def fb_save_token
      page_selected = Koala::Facebook::API.new(
        params[model_name][:fb_page_access_key]
      )
      update_facebook_auth(page_selected.get_object('me')['name'])
      flash[:success] = I18n.t('fb.saved_token')
      redirect_to resource
    end

    def fb_publish
      page_graph = Koala::Facebook::API.new(Auth.find_by_key('facebook').value)
      page_graph.put_wall_post(
        params[model_name][:fb_message],
        {
          link: resource.fb_link,
          name: resource.name
        }
      )
      flash[:success] = I18n.t('fb.posted', user: page_graph.get_object('me')['name'])
      redirect_to resource
    end

  private
    def set_auths_count
      @fb_auths_count = Auth.where(key: 'facebook').count
    end

    def update_facebook_auth(account_selected_name)
      auths = Auth.where(key: 'facebook', name: account_selected_name)
      if auths.count == 0
        Auth.create(
          key: 'facebook',
          name: account_selected_name,
          value: params[model_name][:fb_page_access_key]
        )
      else
        auths.first.update_attribute(:value, params[model_name][:fb_page_access_key])
      end
    end

    def model_name
      @model.name.demodulize.downcase # ex: posts
    end
  end
end
