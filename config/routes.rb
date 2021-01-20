Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :backgrounds, only: [:index]
      resources :forecast, only: [:index]
      post '/road_trip', to: 'road_trip#create'
      post '/sessions', to: 'sessions#create'
      post '/users', to: 'users#create'
    end
  end
end
