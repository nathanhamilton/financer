Financer::Application.routes.draw do

  namespace :users do
    root to: 'envelopes#index'
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
    resources :banks, except: [:index, :show]
    resources :envelopes do
      resources :transactions
    end
  end

  root to: 'static_pages#home'

  get '/about',      to: 'static_pages#about'
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
end
