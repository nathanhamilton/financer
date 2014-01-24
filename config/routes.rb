Financer::Application.routes.draw do

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: 'static_pages#home'

  get '/about',   to: 'static_pages#about'

end
