Financer::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :banks, except: :index
  resources :envelopes do
    resources :transactions
  end

  root to: 'sessions#new'

  get '/dashboard',  to: 'envelopes#index'
  get '/home',       to: 'static_pages#home'
  get '/about',      to: 'static_pages#about'
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
  delete '/signout',    to: 'sessions#destroy'
end
