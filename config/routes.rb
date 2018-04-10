Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
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
    resources :buy_requests, except: %i(show edit update)
    get "following/index"
    get "followers/index"
  end
  get 'request_books/index'
  resources :relationships, only: %i(create destroy)
  resources :account_activations, only: [:edit]

  namespace :admin do
    root "static_pages#index"
    resources :users
    resources :categories
    resources :books, except: :show
    resources :buy_requests
  end
end
