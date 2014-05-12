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
      resources :analytics, resources_parameters(resource).merge(
        { only: [:index] }.merge(rest_path_names)
      )
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
    end
  end

  root to: "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, only: [:new, :create, :destroy]
  delete '/signout', to: 'sessions#destroy', as: 'signout', path: I18n.t('routes.signout')
  get '/signin', to: 'sessions#new', as: 'signin', path: I18n.t('routes.signin')
end
