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
    resources :galleries do
        member do
            put :move_better, :as => "move_to_better"
            put :move_worst, :as => "move_to_worst"
        end
    end
    resources :sessions, :only => [:new, :create, :destroy]

    root :to => 'pages#index'
end