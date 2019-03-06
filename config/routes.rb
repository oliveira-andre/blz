Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}

  resources :filters, only: %i[index destroy]
  resources :establishments do
    resources :services
  end

  resources :services, only: :show do
    post 'details' => 'services#details'
    resources :scheduling, only: %i[create]
  end

  get '/user/:id/dashboard', to: 'user_dashboard#index', as: :user_dashboard
  get '/establishment/:id/dashboard', to: 'establishments_dashboard#index', as: :establishment_dashboard
end
