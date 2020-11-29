Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'signout', to: 'users#signout', as: 'signout'
  match 'users/signin', via: [:get, :post]
  resources :users, only: [:create, :new]
  root 'articles#index'
  resources :categories
  resources :articles
end
