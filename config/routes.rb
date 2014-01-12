Adminpanel::Engine.routes.draw do
    def adminPanelresources
        @controllers ||= find_resources
    end

    def find_resources
        controllersDirectory = 'app/adminpanel/'
        if File.directory?(controllersDirectory)
            controllers = Dir.entries(controllersDirectory).collect do |f|
                filePath = "#{controllersDirectory}#{f}"
                File.file?(filePath) ? filePath.sub!(controllersDirectory, '') : nil
            end
        end
    end

    adminPanelresources.each do |controllers|
        if controllers
            resources controllers.sub!('.rb', '').to_sym
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