Adminpanel::Engine.routes.draw do
    Adminpanel::Router.resources
	resources :sections, :except => [:new]
    resources :users
    resources :galleries do
    	member do
    		put :move_better, :as => "move_to_better"
    		put :move_worst, :as => "move_to_worst"
    	end
    end
    resources :sessions, :only => [:new, :create, :destroy]
    resources :products
    resources :categories
    root :to => 'products#index'
    match '/signout', :to => 'sessions#destroy', :via => :delete, :as => "signout"
    match '/signin', :to => 'sessions#new', :as => "signin"
end
