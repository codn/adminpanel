module Adminpanel
  module FacebookActions
    extend ActiveSupport::Concern
    include ActionView::Helpers::TextHelper

    included do
      before_filter :set_auths_count, only:[:index, :show, :destroy]
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
      ).get_access_token(params[:code]) if params[:code]
      user = Koala::Facebook::API.new(access_token)
      @pages = user.get_connections('me', 'accounts')
      user_object = user.get_object('me')
      @name = user_object['name']
      user_hash = { 'name' => @name, 'access_token' => access_token }
      @pages << user_hash # to permit post on own profile
      render 'shared/fb_choose_page'
    end

    def fb_save_token
      page_selected = Koala::Facebook::API.new(params[@model.name.demodulize.downcase][:fb_page_access_key])
      @auths = Auth.where(key: 'facebook', name: page_selected.get_object('me')['name'])
      if @auths.count == 0
        Auth.create(
          key: 'facebook',
          name: page_selected.get_object('me')['name'],
          value: params[@model.name.demodulize.downcase][:fb_page_access_key]
        )
      else
        @auths.first.update_attribute(:value, params[@mode.name.demodulize.downcase][:fb_page_access_key])
      end
      flash[:success] = I18n.t('fb.saved-token')
      redirect_to resource
    end

    def fb_publish
      page_graph = Koala::Facebook::API.new(Auth.find_by_key('facebook').value)
      page_graph.put_wall_post(
        strip_tags(params[@model.name.demodulize.downcase][:fb_message]),
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
  end
end
