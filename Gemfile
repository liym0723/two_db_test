source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
gem 'mysql2', '0.5.2'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
# This gem works on macOS and Linux. 只能在 linux 和 mac 上
#gem 'bootsnap', '~> 1.4', '>= 1.4.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
 gem 'byebug' # , platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# No test environment
# group :test do
#   # Adds support for Capybara system testing and selenium driver
#   gem 'capybara', '>= 2.15'
#   gem 'selenium-webdriver'
#   # Easy installation and use of chromedriver to run system tests with Chrome
#   gem 'chromedriver-helper'
# end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 网格插件
gem 'wice_grid', '~> 4.1'
gem 'font-awesome-sass',  '~> 4.3'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'pundit', '~> 2.1' # 权限控制插件
gem 'mustache', '~> 1.1', '>= 1.1.1' # 邮件模板插件

gem 'awesome_nested_set', '~> 3.2', '>= 3.2.1' #嵌套集


gem 'sidekiq', '~> 5.2', '>= 5.2.5' # 异步
gem 'redis', '~> 4.1', '>= 4.1.4' # redis

# 需要先启动server redis-server
gem 'sinatra', '~> 2.0', '>= 2.0.8.1' #  sidekiq web可视化

gem 'sidekiq-status', '~> 1.1', '>= 1.1.4' # sidekiq status 监听

gem 'rucaptcha' # 图片验证码
gem 'mocha', '~> 1.11', '>= 1.11.2'
# gem 'kgio', '~> 2.11.3'
gem 'dalli'

# gem 'rails_best_practices', '~> 1.20' # 控制代码质量

gem 'roo', '~> 2.0' # excel 导入
gem 'rubyzip' #, :require => 'zip/zip'
gem 'zip-zip'
gem 'axlsx'

gem 'mini_magick', '~> 4.10', '>= 4.10.1' # 图片处理

# gem 'kaminari' # 分页插件

gem 'pading', path: 'E:\lym_project\gem\pading'
# gem 'pading', '~> 0.1.1'

gem 'simple_form', '~> 5.0', '>= 5.0.2'
gem 'simple_form_imitation', path: 'E:\lym_project\gem\simple_form_imitation'

# 1. excel 各种操作

# 2. 图片的各种处理
gem 'paperclip', '~> 6.1'

# 3. 旧代码的回顾

#  缓存
gem 'actionpack-page_caching', '~> 1.2', '>= 1.2.3' # 页面缓存
gem 'actionpack-action_caching', '~> 1.2', '>= 1.2.1' # 动作缓存

# 检索
gem 'searchkick', '~> 4.4', '>= 4.4.2'