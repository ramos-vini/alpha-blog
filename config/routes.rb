Rails.application.routes.draw do
  root "pages#home"

  resources :articles

  resources :users, except: [:new]

  resources :categories

  get "signup", to: "users#new"

  get "login", to: "session#new"
  post "login", to: "session#create"
  delete "login", to: "session#destroy"
end
