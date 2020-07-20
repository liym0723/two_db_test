require 'sidekiq/web'
require 'sidekiq-status'

# 设置 sidekiq cron 每秒钟检查一次任务，默认是 15 秒钟检查一次任务
Sidekiq.options[:poll_interval]                   = 1
Sidekiq.options[:poll_interval_average]           = 1



# 配置 redis 连接
Sidekiq.configure_client do |config|

  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes

  config.redis = { url: "redis://127.0.0.1:6379/1" }
end



# 设置 sidekiq 服务端
Sidekiq.configure_server do |config|

  # accepts :expiration (optional) 配置服务器中间件
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes

  # accepts :expiration (optional) 配置客户端中间件
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes

  # 配置 redis 连接
  config.redis = { url: "redis://127.0.0.1:6379/1" }

  # 设置 sidekiq 每秒钟都会检查一次作业（默认每5秒检查一次）
  config.average_scheduled_poll_interval = 1

  # 从配置文件中读取定时任务
  schedule_file = 'config/sidekiq_schedule.yml'
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end

  # 配置错误
  # config.error_handlers << proc {|ex,ctx_hash| MyErrorService.notify(ex, ctx_hash) }

  # 配置日志输出格式
  # Sidekiq::Logger::Formatters::Pretty -> 正常出力
  # Sidekiq::Logger::Formatters::WithoutTimestamp -> 无时间戳出力
  # Sidekiq::Logger::Formatters::JSON -> Json 出力
  # config.log_formatter = Sidekiq::Logger::Formatters::JSON.new


  # Sidekiq can also fire a global callback when a job dies 工作终止时，触发全局回调
  config.death_handlers << ->(job, ex) do
    Sidekiq.logger.warn "Liym----- Uh oh, #{job['class']} #{job["jid"]} just died with error #{ex.message}."
  end

  # 生命周期 启动
  config.on(:startup) do
    Sidekiq.logger.warn "Liym----- startup"
    # make_some_singleton
  end
  # 生命周期 等待
  config.on(:quiet) do
    Sidekiq.logger.warn "Liym----- quiet"
  end
  # 生命周期 结束
  config.on(:shutdown) do
    Sidekiq.logger.warn "Liym----- shutdown"
    # stop_the_world
  end
end



#
# # 设置 sidekiq cron 每秒钟检查一次任务，默认是 15 秒钟检查一次任务
# Sidekiq.options[:poll_interval]                   = 1
# Sidekiq.options[:poll_interval_average]           = 1
#
# redis_server = '127.0.0.1' # redis服务器
# redis_port = 6379 # redis端口
# redis_db_num = 1 # redis 数据库序号
# # redis_namespace = 'cool_sidekiq' #命名空间，自定义的
# redis_pool_timeout = 5
#
# # 设置 sidekiq 服务端
# Sidekiq.configure_server do |config|
#
#   # 配置 redis 连接
#   # config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
#   config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}"}
#
#   # 设置 sidekiq 每秒钟都会检查一次作业（默认每5秒检查一次）
#   config.average_scheduled_poll_interval = 1
#
#   # 从配置文件中读取定时任务
#   schedule_file = 'config/sidekiq_schedule.yml'
#   if File.exists?(schedule_file)
#     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
#   end
# end
#
#
# Sidekiq.configure_client do |config|
#   # config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
#   config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}"}
# end
