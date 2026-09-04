Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

##############################################
#   get "/secret", to: "static_pages#secret" # hide page
  get  "/secret/parity-game",
       to: "game#parity",
       as: :parity_game

  post "/secret/parity-game/answer",
       to: "game#answer_parity",
       as: :answer_parity_game
##############################################

  resources :users do
    resources :availabilities,      only: [:edit , :update]
    member do
      get :following
      get :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy] do 
  # resources :microposts do
    member do
      patch :pin
    end
  end

  resources :relationships,       only: [:create, :destroy]
  
  get '/microposts', to: 'static_pages#home'
end
