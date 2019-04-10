require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'callbacks',
    registrations: 'users/registrations'
  }

  resources :filters, only: %i[index destroy]
  resources :establishments do
    resources :services, except: :index do
      resources :professional_services, only: %i[create destroy]
    end
    resources :professionals, except: :index do
      resources :office_hours, only: %i[create destroy]
    end
  end

  resources :services, only: :show

  resources :professional_services, only: :show do
    resources :scheduling, only: %i[new create]
  end

  get '/users/:id/dashboard',
      to: 'users_dashboard#index',
      as: :users_dashboard

  get '/establishments/:id/dashboard',
      to: 'establishments_dashboard#index',
      as: :establishments_dashboard

  resources :callbacks, only: :index
end
