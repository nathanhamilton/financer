Financer::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :banks, except: :index

  root to: 'static_pages#home'

  get '/about',   to: 'static_pages#about'
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'

end
