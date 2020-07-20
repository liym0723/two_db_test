class HardWorker
  include Sidekiq::Worker
  # queue 命名队列，默认default
  # retry 重启次数
  # dead 默认为true  重试失败 是否进入Dead队列 false -> 失败后消失
  sidekiq_options queue: 'critical' # 指定队列
  sidekiq_options retry: 0, dead: false # 0 = 跳过重试，失败了直接加入移至Dead集, false -> 禁止重试


  # The current retry count and exception is yielded. The return value of the
  # block must be an integer. It is used as the delay, in seconds. A return value
  # of nil will use the default.
  # 自定义重试时间
  sidekiq_retry_in do |count, exception|
    case exception
      when SpecialException
        10 * (count + 1) # (i.e. 10, 20, 30, 40, 50)
    end
  end

  # 移至Dead集之前，将调用此挂钩 Dead -> 停滞
  sidekiq_retries_exhausted do |msg, ex|
    Sidekiq.logger.warn "Liym1 - Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(name, count)
    # do something
    aaa
    sleep 100
    10.times do |index|
      user = User.new
      user.name = "root_#{index}"
      user.email = "1507947645@163.com"
      user.save
    end
  end
end