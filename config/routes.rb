include Adminpanel::RouterHelper

Adminpanel::Engine.routes.draw do

  adminpanel_resources.each do |file|
    if file
      resources file.to_sym
    end
  end

	resources :sections, :except => [:new, :create, :destroy]
    match '/signout', :to => 'sessions#destroy', :via => :delete, :as => "signout"
    match '/signin', :to => 'sessions#new', :as => "signin"
    resources :users
    if !Adminpanel.unincluded_modules.include?(:categories)
      resources :categories
    end

    if !Adminpanel.unincluded_modules.include?(:gallery)
      resources :galleries do
        member do
          put :move_better, :as => "move_to_better"
          put :move_worst, :as => "move_to_worst"
        end
      end
    end
    resources :sessions, :only => [:new, :create, :destroy]

    if !Adminpanel.unincluded_modules.include?(:analytics)
      resources :pages, :path => 'analytics', :only => [:index]
      root :to => 'pages#index'
    else
      root :to => 'users#index'
    end
end
