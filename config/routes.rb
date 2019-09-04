# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  root 'pages#home'
  localized do
    devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
    }

    resources :filter_services, only: :index
    resources :filters, only: :index
    resources :establishments do
      collection do
        resources :feedbacks, only: :index, controller: :establishment_feedbacks
      end
      resources :services do
        resources :professional_services, only: %i[create destroy]
      end
      resources :professionals do
        resources :office_hours, only: %i[create destroy]
      end
      resources :welcomes, only: :index, controller: :establishment_welcomes
    end

    resources :photos, only: :destroy
    resources :services, only: :show do
      resource :users, only: %i[edit update]
    end

    resources :scheduling, except: :edit do
      resources :payments, only: %i[new create]
      resources :holders, only: %i[new update]
      resources :reviews, only: :create
      resources :report_problems, only: :create,
                                  controller: :report_scheduling_problems
      resource :status, only: :update, controller: :scheduling_status
      collection do
        resources :busies, only: :create, controller: :scheduling_busies
      end
    end

    # TODO: uncomment when start to create the credit_card
    # resources :payment_cards, only: %i[create index show destroy]

    get '/users/:id/dashboard',
        to: 'users_dashboard#index',
        as: :users_dashboard

    get '/establishments/:id/dashboard',
        to: 'establishments_dashboard#index',
        as: :establishments_dashboard

    get '/para_empresas',
        to: 'pages#sales',
        as: :sales_page

    post '/push' => 'push_notifications#create'

    resources :callbacks, only: :index
    resources :use_rules, only: :index

    namespace :admin do
      resources :scheduling, only: %i[index show]
      resources :services, only: %i[index show update]
      resources :users, only: %i[index show update]
      resources :establishments, only: %i[update index show]
      resources :reviews, only: %i[index show update]
    end
  end
end
