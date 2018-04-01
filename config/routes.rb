Rails.application.routes.draw do
  namespace :admin do
    get 'static_pages/home'
  end

  root "static_pages#home"
  resources :categories, only: :show
  resources :books, only: %i(index show) do
    resources :user_books, only: %i(create update)
    resources :reviews do
      resources :comments
    end
  end
  get "/signup", to: "users#new"
  get "/login", to: "logins#new"
  post "/login", to: "logins#create"
  delete "/logout", to: "logins#destroy"
  resources :users, except: :destroy do
    get "following/index"
    get "followers/index"
  end
  resources :relationships, only: %i(create destroy)
  resources :account_activations, only: [:edit]
end
