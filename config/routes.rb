Rails.application.routes.draw do
  namespace :admin do
    get 'static_pages/home'
  end

  root "static_pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
