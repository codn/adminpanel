Adminpanel::Engine.routes.draw do

    if !Adminpanel::Router.adminpanel_resources.nil?
        Adminpanel::Router.adminpanel_resources.each do |file|
            if file
                resources file.sub!('.rb', '').to_sym
            end
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

    root :to => 'galleries#index'
end