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
          get :google, to: 'analytics#index', as: 'google', path: 'google'
          get :fb, to:'analytics#fb', as: 'fb', path:'facebook'
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

      # normal resource
      resources resource, resources_parameters(resource).merge(rest_path_names)

      # if resource is going to be shared on facebook
      resources resource, resources_parameters(resource).merge(rest_path_names) do
        member do
          if has_fb_share?(resource)
            get :fb_choose_page, as: 'fb_choose_page', path: 'publicar-a-pagina-en-fb'
            post :fb_save_token, as: 'fb_save_token', path: 'guardar-token'
            post 'fb_publish/:configuration_id', to: "#{resource}#fb_publish", as: 'fb_publish', path: 'publicar-a-facebook'
          end
        end
      end
    end
  end

  root to: "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, only: [:new, :create, :destroy]
  delete '/signout', to: 'sessions#destroy', as: 'signout', path: I18n.t('routes.signout')
  get '/signin', to: 'sessions#new', as: 'signin', path: I18n.t('routes.signin')
end
