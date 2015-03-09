include Adminpanel::RouterHelper

Adminpanel::Engine.routes.draw do

  Adminpanel.displayable_resources.each do |resource|
    case resource
    when :analytics
      resources :analytics, resources_parameters(resource).merge({ only: [:index] }) do
        collection do
          get :google,               to: 'analytics#google', path: 'google'

          get :fb,                   to:'analytics#fb',      path:'facebook'

          get :twitter,              to:'analytics#twitter', path:'twitter'
          post 'reply_to_tweet/:id', to: 'analytics#reply_to_tweet', as: 'reply_to', path: "twitter/#{I18n.t('routes.reply')}/:id"
          post 'favorite_tweet/:id', to: 'analytics#favorite_tweet', as: 'favorite', path: "twitter/#{I18n.t('routes.favorite')}/:id"
          post 'retweet_tweet/:id',  to: 'analytics#retweet_tweet',  as: 'retweet',  path: "twitter/#{I18n.t('routes.retweet')}/:id"

          get :instagram,            to:'analytics#instagram'
          post 'comment_to_instagram/:id', to: 'analytics#instagram_comment', as: 'comment_instagram', path: "instagram/#{I18n.t('routes.comment')}/:id"
        end
      end
    else
      if get_gallery_children(resource)
        # include galleryzation concern
        resources get_gallery_children(resource).to_sym, only: [:index] do
          member do
            put :move_gallery_better, as: 'move_gallery_to_better', path: I18n.t('routes.move_gallery_to_better')
            put :move_gallery_worst,  as: 'move_gallery_to_worst', path: I18n.t('routes.move_gallery_to_worst')
          end
        end
      end

      resources resource, resources_parameters(resource).merge(rest_path_names) do
        member do
          # adds custom member routes of the resource
          member_routes(resource).each do |route|
            route.each do |request_type, args|
              send(request_type, args['path'].to_sym, args['args'])
            end
          end

          if is_sortable?(resource)
            # include sortable concern
            put :move_to_position, as: 'move_to_position', path: I18n.t('routes.move_to_position')
          end

          if has_fb_share?(resource)
            # include facebook concern
            get :fb_choose_page, as: 'fb_choose_page', path: I18n.t('routes.publish', location: I18n.t('routes.facebook_page'))
            post :fb_save_token, as: 'fb_save_token', path: 'guardar-token-fb'
            post :fb_publish, to: "#{resource}#fb_publish", as: 'fb_publish', path: I18n.t('routes.publish', location: 'facebook')
          end

          if has_twitter_share?(resource)
            # include twitter concern
            post :twitter_publish, to: "#{resource}#twitter_publish", as: 'twitter_publish', path: I18n.t('routes.publish', location: 'twitter')
          end
        end

        collection do
          # add custom collection routes of the resource
          collection_routes(resource).each do |route|
            route.each do |request_type, args|
              send(request_type, args['path'].to_sym, args['args'])
            end
          end
        end
      end
    end
  end

  root to: "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, only: [:new, :create, :destroy] do
    collection do
      get 'instagram_login'
      get 'instagram_callback'
    end
  end
  delete '/signout', to: 'sessions#destroy', as: 'signout', path: I18n.t('routes.signout')
  get    '/signin',  to: 'sessions#new',     as: 'signin',  path: I18n.t('routes.signin')

end

Rails.application.routes.draw do
  #route for oauth2 twitter callback
  get 'auth/twitter/callback', to: 'adminpanel/sessions#twitter_callback'
end
