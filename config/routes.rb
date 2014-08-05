include Adminpanel::RouterHelper

Adminpanel::Engine.routes.draw do

  Adminpanel.displayable_resources.each do |resource|
    case resource
    when :sections
      # sections cannot be created or destroyed
      resources :sections, resources_parameters(resource).merge(
      { except: [:new, :create, :destroy] }.merge(rest_path_names)
      )
    when :galleries
      # galleries gallery is different from normal resources galleries
      resources :galleries, resources_parameters(resource).merge(rest_path_names) do
        member do
          put :move_better, as: 'move_to_better', path: 'subir-prioridad'
          put :move_worst, as: 'move_to_worst', path: 'bajar-prioridad'
        end
      end
    when :analytics
      resources :analytics, resources_parameters(resource).merge({ only: [:index] }) do
        collection do
          get :google, to: 'analytics#google', path: 'google'
          get :fb, to:'analytics#fb', path:'facebook'
          get :twitter, to:'analytics#twitter', path:'twitter'
          post 'reply_to_tweet/:id', to: 'analytics#reply_to_tweet', as: 'reply_to', path: 'twitter/responder/:id'
          post 'favorite_tweet/:id', to: 'analytics#favorite_tweet', as: 'favorite', path: 'twitter/favorito/:id'
          post 'retweet_tweet/:id', to: 'analytics#retweet_tweet', as: 'retweet', path: 'twitter/retweet/:id'
          get :instagram, to:'analytics#instagram'
          post 'comment_to_instagram/:id', to: 'analytics#instagram_comment', as: 'comment_instagram', path: 'instagram/comentar/:id'
        end
      end
    else
      if !get_gallery_children(resource).nil?
        # make the resources gallery routes
        resources get_gallery_children(resource).to_sym, only: [:index] do
          member do
            put :move_better, as: 'move_to_better', path: 'subir-prioridad'
            put :move_worst, as: 'move_to_worst', path: 'bajar-prioridad'
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
          if has_fb_share?(resource)
            # if resource is going to be shared on facebook
            get :fb_choose_page, as: 'fb_choose_page', path: 'publicar-a-pagina-en-fb'
            post :fb_save_token, as: 'fb_save_token', path: 'guardar-token-fb'
            post :fb_publish, to: "#{resource}#fb_publish", as: 'fb_publish', path: 'publicar-a-facebook'
          end
          if has_twitter_share?(resource)
            post :twitter_publish, to: "#{resource}#twitter_publish", as: 'twitter_publish', path: 'publicar-a-twitter'
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
  get '/signin', to: 'sessions#new', as: 'signin', path: I18n.t('routes.signin')

end

Rails.application.routes.draw do
  #route for oauth2 twitter callback
  get 'auth/twitter/callback', to: 'adminpanel/sessions#twitter_callback'
end
