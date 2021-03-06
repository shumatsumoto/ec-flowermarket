Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  resources :products
  resources :orders
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  root to: 'products#index'
  
  resources :products do
    member do
      post 'purchase'
    end
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end
