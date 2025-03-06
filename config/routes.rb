Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  # Root path for the landing page and login
  root "sessions#new"

  # Session management for the user name
  resource :session, only: [:new, :create, :destroy]
  
  # Posts with nested comments
  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end
  
  # Likes functionality (for later)
  resources :likes, only: [:create, :destroy]

  # Below is auto-generated routes. I'm not planning on using them, but leaving them here as comments for reference until I'm sure they can be deleted.
  # get "comments/create"
  # get "comments/update"
  # get "comments/destroy"
  # get "posts/index"
  # get "posts/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
