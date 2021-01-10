Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  resources :products
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  root to: 'products#index'

end
