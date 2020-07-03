Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"
  get "about", to: "pages#about"

  # this will give us all of the routes for articles
  resources :articles

  # this lets us specify routes we want to only use
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update]

  get "sign_up", to: "users#new"
  # excluding :new route from resources since we manually defined it as "/sign_up" instead of "/users/new"
  resources :users, except: [:new]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :categories
end
