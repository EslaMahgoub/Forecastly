Rails.application.routes.draw do
  root 'pages#home'
  get     '/about',  to: 'pages#about'
  get     '/signup', to: 'users#new'
  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'
  resources :users
  resources :cities, only: %i[index create destroy]
  # get :temperature, controller: :pages
end
