Rails.application.routes.draw do
  namespace :admin do
    get 'static_pages/home'
  end

  root "static_pages#home"

  resources :categories, only: :show
end
