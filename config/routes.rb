Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  resources :filters, only: %i[index destroy]
  resources :establishments do
    resources :services
  end

  resources :services, only: :show do
    get 'details' => 'services#details'
    resources :scheduling, only: :new
  end
end
