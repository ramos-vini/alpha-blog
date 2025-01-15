Rails.application.routes.draw do
  root "pages#home"

  resources :articles

  get "signup", to: "users#new"

  resources :users, except: [:new]

  get "login", to: "session#new"
  post "login", to: "session#create"
  delete "login", to: "session#destroy"
end
