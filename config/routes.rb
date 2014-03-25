Adminpanel::Engine.routes.draw do

  Adminpanel.displayable_resources.each do |resource|
    case resource
    when :sections
      resources :sections, :except => [:new, :create, :destroy]
    when :users
      resources :users
    when :galleries
      resources :galleries do
        member do
          put :move_better, :as => "move_to_better"
          put :move_worst, :as => "move_to_worst"
        end
      end
    when :categories
      resources :categories
    when :analytics
      resources :analytics, :only => [:index]
    else
      resources resource
    end
  end

  root :to => "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, :only => [:new, :create, :destroy]
  match '/signout', :to => 'sessions#destroy', :via => :delete, :as => "signout"
  match '/signin', :to => 'sessions#new', :as => "signin"
end
