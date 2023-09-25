Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'forecast', to: 'forecast#index'
      resources :users, only: [:create]
      post 'sessions', to: 'sessions#create'
      get 'book_search', to: 'book_search#search'
    end
  end
end