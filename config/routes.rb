Rails.application.routes.draw do
  root 'users#index'
  resources :users do
    collection do
      get 'mustache_test'
      get 'excel_download'
    end
  end

  resources :admins

  resources :import_jimu_applies
  resources :blogs do
    collection do
      post 'index'
    end

  end

  resources :kaminari_tests
  resources :simple_form_test
  namespace :library do
    resources :books
  end

  # sidekiq 可视化路由
  # http://localhost:port/sidekiq

  # https://github.com/mperham/sidekiq/wiki/Monitoring 可视化路由的身份验证

  require 'sidekiq/web'
  require 'sidekiq-status/web' # 增加status web
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # sidekiq + devise
  # authenticate :user, lambda { |u| u.admin? } do
    # mount Sidekiq::Web => '/sidekiq'
  # end

  # config/routes.rb
  # require "admin_constraint"
  # mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new


  # rucaptcha 图片验证
  # mount RuCaptcha::Engine => "/rucaptcha"
end
