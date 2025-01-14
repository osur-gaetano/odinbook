Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :users, only: %i[ index show ]

  resources :posts do
    resources :comments
  end

  put "posts/:id/like", to: "posts#like", as: "like"
  delete "posts/:id/like", to: "posts#unlike", as: "unlike"


  put "users/send_request/:following_id", to: "users#send_request", as: "send_follow_request"
  put "users/approve_request/:follower_id", to: "users#approve_request", as: "approve_follow_request"
  delete "users/reject_request/:follower_id", to: "users#reject_request", as: "reject_follow_request"




  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "posts#index"
end
