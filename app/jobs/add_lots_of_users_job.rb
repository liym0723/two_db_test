class AddLotsOfUsersJob < ApplicationJob
  queue_as :default
  queue_with_priority 50 # 设置整个队列的优先级


  # after_enqueue :after_enqueue1
  # before_enqueue :before_enqueue1
  # around_enqueue :around_enqueue1
  #
  #
  # after_perform :after_perform1
  # before_perform :before_perform1
  # around_perform :around_perform1

  # AddLotsOfUsersJob.perform_later
  def perform(*args)
    # Do something later
    # aaa
    5.times do |index|
      #sleep 50
      total 10 # by default

      at 5, "Almost done" # 5/100 = 5 % completion

      # a way to associate data with your job
     # store vino: 'veritas'

      # a way of retrieving stored data
      # remember that retrieved data is always String|nil
     # vino = retrieve :vino

      user = User.new
      user.name = "root_#{index}"
      user.email = "1507947645@163.com"
      user.save
    end
  end



  def after_enqueue1
    pp "after enqueue"
  end

  def before_enqueue1
    pp "before enqueue"
  end


  def around_enqueue1
    pp "around enqueue"
  end

  def after_perform1
    pp "after perform"
  end

  def before_perform1
    pp "before perform"
  end


  def around_perform1
    pp"around perform"
  end
end
