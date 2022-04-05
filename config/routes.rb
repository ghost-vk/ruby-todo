Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :users, only: [:create]

  resources :projects do
    resources :todos
  end

  resources :todos, only: [:create, :update, :destroy]

  post "/login", to: "users#login"
  post "/register", to: "users#create"
  get "/auto_login", to: "users#auto_login"
end
