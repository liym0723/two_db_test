class SidekiqApi



  # 反回全部的队列
  Sidekiq::Queue.all # ->[#<Sidekiq::Queue:0x0000000007c63980 @name="critical", @rname="queue:critical">, #<Sidekiq::Queue:0x0000000007c638e0 @name="default", @rname="queue:default">]

  # 查询对应的队列 queue_name 默认 = default
  Sidekiq::Queue.new("queue_name")

  # 反回队列的作业数
  Sidekiq::Queue.new.size #

  # 删除队列 以及队列的作业
  Sidekiq::Queue.new.clear # [1,true]

  # 根据ID删除作业
  queue = Sidekiq::Queue.new("mailer")
  queue.each do |job|
    job.klass # => 'MyWorker'
    job.args # => [1, 2, 3]
    job.delete if job.jid == 'abcdef1234567890'
  end

  # 获取重试队列
  Sidekiq::RetrySet.new

  # 获取Dead 队列
  Sidekiq::DeadSet.new
end
