require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :products
      resources :categories
      resources :purchases
      resources :clients
      resources :admin_users
      get 'reports/top_products_per_category', to: 'reports#top_products_per_category'
      get 'reports/top_revenue_products_per_category', to: 'reports#top_revenue_products_per_category'
      get 'reports/filtered_purchases', to: 'reports#filtered_purchases'
      get 'reports/purchases_aggregate', to: 'reports#purchases_aggregate'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
