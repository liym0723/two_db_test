
require 'pp'
class ChainQueue
  # 队列， 先进先出
  # 链式存储结构成为 链队

  attr_accessor :front, :rear
  Node = Struct.new(:val, :next)
  # 队列
  def initialize (*values)
    values.each {|v| push(v)}
  end

  # 入队 追加尾元素
  def push v
    node = Node.new(v)
    if @front.nil? # 空队列
      @front = @rear = node
    else
      @rear.next = node
      @rear = node
    end
  end

  # 出队 -> 删除头元素
  def pop
    return if @rear.nil?
    @front = @front.next
    @rear = nil if @rear == @front # 如果只存在一个
  end

  def to_s
    node = @front
    s = []
    while !node.nil?
      s << node.val
      node = node.next
    end
    s.join(' -> ')
  end

end

queue = ChainQueue.new(1,2,3,4,5)
pp queue.to_s

queue.push 7
queue.pop
pp queue.to_s