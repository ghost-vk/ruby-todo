Rails.application.routes.draw do
  resources :projects do
    resources :todos
  end

  resources :todos
end
