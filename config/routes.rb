Opensit::Application.routes.draw do

  root :to => "users#me"

  devise_for :users, :controllers => { :registrations => "registrations" }
  get 'me' => "users#me"
  get '/u/:username' => "users#show", :as => :user
  get '/u/:username/following' => "users#following", :as => :following_user
  get '/u/:username/followers' => "users#followers", :as => :followers_user
  get '/u/:username/export' => "users#export"
  get '/u/:username/feed' => "users#feed", :as => :feed, :defaults => { :format => 'atom' }
  get '/favs' => "favourites#index", :as => :favs
  get '/notifications' => "notifications#index"

  get '/search' => "search#main"

  get 'front' => "pages#front"
  get 'about' => "pages#about"
  get 'contact' => "pages#contact"
  get 'explore' => "pages#explore"
  get 'explore/tags' => "pages#tag_cloud", :as => :explore_tags
  get 'explore/users/new' => "pages#new_users", :as => :explore_new_users
  get 'global-feed' => "users#feed", :defaults => { :format => 'atom', :scope => 'global' }

  resources :sits do
    resources :comments
  end

  get '/tags/:id' => 'tags#show', :as => :tag

  get '/messages/sent' => "messages#sent", :as => :sent_messages
  resources :messages, except: [:edit, :update]

  resources :relationships, only: [:create, :destroy]

  resources :favourites, only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]

  # Crawl live site, but not staging
  get 'robots.txt' => 'pages#robots'

end
