require "sidekiq/web"

Rails.application.routes.draw do
  root 'welcome#index'
end
