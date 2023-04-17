require "sidekiq/web"

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/signup", to: "users#new"
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/activation", to: "payments#activation"
    resources :payments
    resources :order_historys
    resources :payment_activations, only: :edit
    resources :tickets
    resources :users
    resources :movies, only: %i(show) do
      resources :shows
    end

    namespace :admin do
      root "static_pages#home"
      resources :movies
      resources :categories
      resources :users
    end
  end
end
