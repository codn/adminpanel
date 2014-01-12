Adminpanel::Engine.routes.draw do
    def adminPanelresources
        @files ||= find_resources
    end

    def find_resources
        resources_path = "#{Rails.root.to_s}/app/adminpanel/"
        if File.directory?(resources_path)
            files = Dir.entries(resources_path).collect do |f|
                file_path = "#{resources_path}#{f}"
                File.file?(file_path) ? file_path.sub!(resources_path, '') : nil
            end
        end
    end

    adminPanelresources.each do |file|
        if file
            resources file.sub!('.rb', '').to_sym
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