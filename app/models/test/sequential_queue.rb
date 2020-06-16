# 顺序队列 -> 循环队列
# 依赖数组实现。
require 'pp'
class SequentialQueue

  # front 队头, rear 队尾, flag 用来判断是否已满
  # front, rear 用来记录下标
  attr_accessor :front, :rear, :queue_array
  def initialize(*values)
    values = values.flatten
    return if values.nil?
    return if values.length > max_size
    @queue_array = values # 存储顺序队列
    @front = 0 # 记录队头下标
    @rear = @queue_array.length >= max_size ? 0 : @queue_array.length
  end

  # 入队列
  def push v
    return if is_empty? # 链表已满 不进行存储
    @queue_array[@rear] = v
    @rear += 1
    @rear = 0 if @rear >= max_size
  end

  # 出队列
  def pop
    return if @front == nil && @front == nil  # 如果队列空了无法删除

    @queue_array[@front] = nil
    @front += 1
    @front = 0 if @front >= max_size
  end


  # 判断 队列是否为空
  def is_empty?
    # 长度已经等于最大长度了 并且不包含空
    @queue_array.length == max_size && !@queue_array.include?(nil)
  end

  # 循环队列的最大长度
  def max_size
    41
  end

  # 约瑟夫环 K -> 从第几个人开始报数。 m -> 每几个人出列
  def cycle k,m
    # k 取代队列的头
    pop_queue = [] # 记录出列的顺序
    pop_number = 0 # 记录出队列次数

    while @queue_array.length >= m
      pop_number += 1
      k = 1 if k > @queue_array.length # 如果超过了人数 从第一个人开始
      if pop_number == m
        pop_queue << @queue_array[k - 1]
        @queue_array.delete_at(k - 1)
        pop_number = 0
      else
        k += 1
      end

    end

    pp pop_queue # 淘汰的人
    pp @queue_array # 剩下的人
  end

  def to_s
    "队尾下标为#{@rear},队头下标为#{@front}, 队列数组为#{@queue_array}"
  end
end


# queue = SequentialQueue.new(1,2,3,4,5)
# queue.push 6
# queue.push 7
# queue.push 8
# pp queue.to_s
#
# queue.pop
# queue.pop
# queue.pop
# queue.pop
# queue.pop
# queue.pop
# queue.pop
#
# pp queue.to_s
#
# queue.push 1
# queue.push 2
# queue.pop
# pp queue.to_s
queue = SequentialQueue.new(Array(1..41))

# K -> 从第几个人开始报数。 m -> 每几个人出列
queue.cycle 1,3
