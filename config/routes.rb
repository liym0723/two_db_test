Rails.application.routes.draw do
  root 'users#index'
  resources :users

  namespace :library do
    resources :books
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
