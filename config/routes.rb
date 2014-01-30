Financer::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'

  get '/about',   to: 'static_pages#about'
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  get '/signout', to: 'sessions#destroy', via: 'delete'

end
