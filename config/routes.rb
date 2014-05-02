include Adminpanel::RouterHelper

Adminpanel::Engine.routes.draw do

  Adminpanel.displayable_resources.each do |resource|
    case resource
    when :sections
      # sections cannot be created or destroyed
      resources :sections, resources_parameters(resource).merge({:except => [:new, :create, :destroy] })
    when :galleries
      # galleries gallery is different from normal resources galleries
      resources :galleries, resources_parameters(resource) do
        member do
          put :move_better, :as => 'move_to_better'
          put :move_worst, :as => 'move_to_worst'
        end
      end
    when :analytics
      resources :analytics, resources_parameters(resource).merge({:only => [:index]})
    else
      if !gallery_children(resource).nil?
        # make the resources gallery routes
        resources gallery_children(resource).to_sym, :only => [:index] do
          member do
            put :move_better, :as => 'move_to_better'
            put :move_worst, :as => 'move_to_worst'
          end
        end
      end

      # normal resource
      resources resource, resources_parameters(resource)
    end
  end

  root :to => "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, :only => [:new, :create, :destroy]
  delete '/signout', :to => 'sessions#destroy', :as => "signout"
  get '/signin', :to => 'sessions#new', :as => "signin"
end
