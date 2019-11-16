# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get '/show/:id', to: 'users#show', as: 'user'
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root 'posts#index'
  resources :posts, only: %i[index create edit update destroy new]
  resources :comments
  resources :likes
end
