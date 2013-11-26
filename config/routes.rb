Adminpanel::Engine.routes.draw do
  	# resources :sections, :except => [:new]
   #  resources :users
   #  resources :galleries
   #  resources :sessions, :only => [:new, :create, :destroy]
   #  resources :products
    resources :pages
    root :to => "pages#index"
    # root :to => 'products#index'
    # match '/signout', :to => 'sessions#destroy', :via => :delete
    # match '/signin', :to => 'sessions#new'
end
