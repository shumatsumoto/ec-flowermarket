Rails.application.routes.draw do
  resources :products
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  root to: 'products#index'

end
