Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'add_api_route', to: 'api_routes#add_api_route'
  resources :articles
  resources :api_categories
  resources :api_routes

  namespace :api do
    resources :articles
  end

end
