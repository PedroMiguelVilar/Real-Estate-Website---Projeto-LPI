Rails.application.routes.draw do
  resources :search_suggestions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/index', to: 'house#index'
  get '/contact', to: 'house#contact'
  get '/about', to: 'house#about'
  #get 'houses/search', to: 'house#search'
  get '/property-grid', to: 'house#property_grid', as: 'search_houses'
  get '/property_single', to: 'house#property_single'
  post '/pages/test', to: 'pages#test'

  resources :houses do
    member do
      get 'property_single/:id', to: 'house#property_single', as: 'property_single'
    end
  end
  
  get '/scrape', to: 'pages#scrape'

  resources :users, only: [:new, :create]
  get '/users/login', to: 'users#login', as: 'login'
  post '/users/login', to: 'users#login'
  delete '/logout', to: 'users#logout', as: 'logout'





end
