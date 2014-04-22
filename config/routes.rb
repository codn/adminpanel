include Adminpanel::RouterHelper

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
      if !acts_as_a_gallery?(resource).nil?
        resources resource
        resources acts_as_a_gallery?(resource).to_sym, :only => [:index] do
          member do
            put :move_better, :as => 'move_to_better'
            put :move_worst, :as => 'move_to_worst'
          end
        end
      else
        resources resource
      end
    end
  end

  root :to => "#{Adminpanel.displayable_resources.first}#index"
  resources :sessions, :only => [:new, :create, :destroy]
  delete '/signout', :to => 'sessions#destroy', :as => "signout"
  get '/signin', :to => 'sessions#new', :as => "signin"
end
