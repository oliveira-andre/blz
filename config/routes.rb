require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/notification'

  root 'pages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'callbacks',
    registrations: 'users/registrations'
  }

  resources :filters, only: :index
  resources :establishments do
    resources :services, except: :index do
      resources :professional_services, only: %i[create destroy]
    end
    resources :professionals, except: :index do
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

  get '/users/:id/dashboard',
      to: 'users_dashboard#index',
      as: :users_dashboard

  get '/establishments/:id/dashboard',
      to: 'establishments_dashboard#index',
      as: :establishments_dashboard

  resources :callbacks, only: :index

  namespace :admin do
    resources :scheduling, only: :index
    resources :services, only: :index
    resources :users, only: :index
  end
end