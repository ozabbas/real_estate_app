Rails.application.routes.draw do
  devise_for :accounts
  resources :posts, except: [:show]
  resources :properties
  resources :viewings, except: [:show]
  resources :contacts, only: [:index, :destroy]

  post "viewing/approve" => "viewings#approve_viewing", as: :approve_viewing
  post "viewing/decline" => "viewings#decline_viewing", as: :decline_viewing

  get "/blog" => "posts#latest", as: :blog
  get "/blog/:url" => "posts#show", as: :blog_post

  # admin routes
  get "/accounts" => 'admin#accounts', as: :accounts

  # get "/dashboard" => 'dashboard#index', as: :dashboard
  get "/latest-properties" => 'public#latest_properties', as: :latest_properties
  get "/profile/:id" => 'dashboard#profile', as: :profile
  post "/agent/message" => "properties#email_agent", as: :email_agent

  root to: 'public#main'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
