Rails.application.routes.draw do
  class OnlyAjaxRequest
     def matches?(request)
       request.xhr?
     end
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'markdown_result', to: 'articles#markdown_result', as: 'markdown_result'


  resources :articles
  resources :comments
  resources :questions

  namespace :api do
    resources :articles, only: [:index, :show]
    resources :contact_forms, only: [:create]
    resources :comments, only: [:index, :create]

    namespace :v1 do
      get '/start_game', to: 'puzzles#random_gen'
      post '/login', to: 'auth#create'
      get '/me', to: 'auth#show'

      resources :users
      resources :words
      resources :grid_boxes
      resources :puzzle_words
      resources :puzzles
    end
  end

end
