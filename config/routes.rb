Financer::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :banks, except: [:index, :show]
  resources :envelopes do
    resources :transactions
  end

  root to: 'envelopes#index'

  get '/about',      to: 'static_pages#about'
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/dashboard',  to: 'envelopes#index'

end
