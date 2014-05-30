module Adminpanel
  module FacebookActions
    extend ActiveSupport::Concern
    include ActionView::Helpers::TextHelper
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
      @pages << user_hash
      render 'shared/fb_choose_page'
    end

    def fb_publish
      if params[@model.name.demodulize.downcase][:fb_page_access_key].present? &&
        params[@model.name.demodulize.downcase][:fb_message].present?
        page_graph = Koala::Facebook::API.new(params[@model.name.demodulize.downcase][:fb_page_access_key])
        page_graph.put_wall_post(
          strip_tags(params[@model.name.demodulize.downcase][:fb_message]),
          {
            link: resource.fb_link,
            name: resource.name
          }
        )
        flash[:success] = I18n.t('fb.posted', user: page_graph.get_object('me')['name'])
        redirect_to resource
      else
        flash[:error] = I18n.t('fb.not-posted')
        redirect_to resource
      end
    end

  private
  end
end
