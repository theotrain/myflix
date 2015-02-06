Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resources :videos do
    collection do
      get '/search', to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]
  resources :users, only: [:create]
  get '/my_queue', to: 'queue_items#index'
  post '/my_queue', to: 'queue_items#create'
  resources :queue_items, only: [:destroy]
  post '/reorder_queue', to: 'queue_items#reorder'
end
