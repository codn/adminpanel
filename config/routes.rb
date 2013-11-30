Adminpanel::Engine.routes.draw do
  	resources :sections, :except => [:new]
    resources :users
    resources :galleries
    resources :sessions, :only => [:new, :create, :destroy]
    resources :products
    resources :categories
    root :to => 'products#index'
    match '/signout', :to => 'sessions#destroy', :via => :delete, :as => "signout"
    match '/signin', :to => 'sessions#new', :as => "signin"
end
