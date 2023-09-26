Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'forecast', to: 'forecast#index'
      resources :users, only: [:create]
      post 'sessions', to: 'sessions#create'
      post 'road_trip', to: 'road_trip#create'
    end
  end
end