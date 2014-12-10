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
  end
  resources :categories
  resources :users, only: [:create]
  # resources :users
  # resources :sessions, only: [:front]
end




# resources :todos, only: [:index] do
#     collection do
#         get ‘search’, to: ‘todos#search’ #/todos/search
#     end

#     member do
#         post ‘highlight’, to: ‘todos#highlight’  #/todos/:id/highlight
#     end
# end
