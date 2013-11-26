Adminpanel::Engine.routes.draw do
  	resources :sections, :except => [:new]
    resources :users
    resources :galleries
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :sessions, :only => [:new, :create, :destroy]
    resources :products
    root :to => 'products#index'
    match '/signout', :to => 'sessions#destroy', :via => :delete
    match '/signin', :to => 'sessions#new'
end
