
require_relative 'boot' # 引入gem


require 'rails/all'
require 'pp'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# 直接将Gemfile列举的依赖全部载入内存
Bundler.require(*Rails.groups) # 主要是基于方便开发者（Programmer Friendly）的考量，它使开发者省去了大量的精力去显式地加载代码。
module TwoDbTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/**/)

      config.autoload_paths

#    config.middleware.use Rack::Attack
    # 配合 active job 默认使用的是 :inline
    config.active_job.queue_adapter = :sidekiq # 使用 sidekiq 作为异步任务的适配器

    # 给所有的队列名增加前缀
    # config.active_job.queue_name_prefix = "xx"
  end
end
