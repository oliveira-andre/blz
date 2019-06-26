require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  root 'pages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'callbacks',
    registrations: 'users/registrations'
  }

  resources :filters, only: :index
  resources :establishments do
    resources :services do
      resources :professional_services, only: %i[create destroy]
    end
    resources :professionals do
      resources :office_hours, only: %i[create destroy]
    end
  end

  resources :photos, only: :destroy
  resources :services, only: :show

  resources :scheduling, only: %i[new create show] do
    resources :payments, only: %i[new create]
    resources :holders, only: %i[new update]
    resources :reviews, only: :create
  end

  resources :payment_cards, only: %i[create index show destroy]

  get '/users/:id/dashboard',
      to: 'users_dashboard#index',
      as: :users_dashboard

  get '/establishments/:id/dashboard',
      to: 'establishments_dashboard#index',
      as: :establishments_dashboard

  resources :callbacks, only: :index
  resources :use_rules, only: :index

  namespace :admin do
    resources :scheduling, only: %i[index show]
    resources :services, only: %i[index show update]
    resources :users, only: %i[index show update]
  end
end
