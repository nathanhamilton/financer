Financer::Application.routes.draw do
  resources :users

  root to: 'static_pages#home'

  get '/about',   to: 'static_pages#about'
  get '/signup',  to: 'users#new'

end
