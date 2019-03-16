Rails.application.routes.draw do

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
    resources :professionals, except: :index
  end

  resources :services, only: :show do
    post 'details' => 'services#details'
    resources :scheduling, only: %i[create]
    resources :office_hours, only: %i[create destroy]
  end

  get '/users/:id/dashboard',
      to: 'users_dashboard#index',
      as: :users_dashboard

  get '/establishments/:id/dashboard',
      to: 'establishments_dashboard#index',
      as: :establishments_dashboard
end
