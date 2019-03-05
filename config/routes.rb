Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}

  resources :filters, only: %i[index destroy]
  resources :establishments do
    resources :services
  end

  resources :services, only: :show do
    get 'details' => 'services#details'
    resources :scheduling, only: %i[new create]
    resources :office_hours, only: %i[create destroy]
  end

  get '/user/:id/dashboard', to: 'user_dashboard#index', as: :user_dashboard
end
