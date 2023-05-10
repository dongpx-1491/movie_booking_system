require "sidekiq/web"

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/signup", to: "users#new"
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/activation", to: "payments#activation"
    get "/showing_movie", to: "specific_movies#showing_movie"
    get "/comming_movie", to: "specific_movies#comming_movie"
    resources :payments
    resources :searchs, only: :index
    resources :order_historys
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(show destroy index)
    resources :payment_activations, only: :edit
    resources :tickets
    resources :users
    resources :rates, only: :create
    resources :categories, only: :show
    resources :favorites, only: %i(index create destroy)
    resources :movies, only: %i(show) do
      resources :shows
    end

    resources :charts, only: [] do
      collection do
        get "top_movies_seller"
        get "top_movies_booking"
        get "revenue_by_day"
      end
    end

    namespace :admin do
      root "static_pages#home"
      get "/home", to: "static_pages#home"
      resources :movies
      resources :categories
      resources :show_times
      resources :cinemas
      resources :payments
      resources :users, only: %i(index show update)
    end
    mount Sidekiq::Web => "/sidekiq"
  end
end
