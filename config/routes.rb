Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :index
      resources :verticals
      resources :categories
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'
    end
  end
end
