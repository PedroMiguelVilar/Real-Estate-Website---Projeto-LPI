Rails.application.routes.draw do
  resources :search_suggestions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/index', to: 'house#index'
  get '/contact', to: 'house#contact'
  get '/about', to: 'house#about'
  get 'houses/search', to: 'house#search', as: 'search_houses'
  resources :houses
  get '/test', to: 'house#test'
end
