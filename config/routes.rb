Rails.application.routes.draw do

  # get 'users/my_portfolio'
  #devise_for :users, path: 'auth', path_names: {sign_in: 'login'}
  devise_for :user

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'my_portfolio', to: 'users#my_portfolio' #, as: 'scott'

  get 'search_stock', to: 'stocks#search'

  resources :user_stocks, only: [:create, :destroy]



end
