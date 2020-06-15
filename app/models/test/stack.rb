require 'pp'
class Stack
  # @top 栈顶， length 栈长
  attr_accessor :top, :length
  Node = Struct.new(:val, :next)

  def initialize values
    values.each{|v| push v}
  end


  # 压栈 -> 新增
  def push v
    @length = 0 if @length.nil?
    @length += 1
    node = Node.new(v)

    node.next = @top # 栈顶的下一个是之前的栈顶
    @top = node # 记录栈顶
  end

  # 出栈 -> 删除
  def pop
    return if is_empty?
    pop_value = @top.val
    @top = @top.next # 栈顶变成下一个

    @length -= 1
    pop_value
  end

  # 判断栈是否为空
  def is_empty?
    @length == nil || @length == 0
  end

  def to_s
    node = @top
    s = []
    while !node.nil?
      s << node.val
      node = node.next
    end
    s.join(' -> ')
  end

  # 判断字符串是否有效
  def self.check_str str
    pp str
    h = {"(" => ")", "{" => "}", "[" => "]" }
    str_arr = str.split(" ") # 字符串转换为数组
    stack = Stack.new([])# 创建一个空栈出来
    str_arr.each do |s|
      return if s.nil?
      return false if h[s].nil? && !(h.values.include?(s)) # 不是合法字符无法进入

      if h[s] != nil
        # 入栈
        stack.push s
      else
        # 出栈
        pop_value = stack.pop
        return false if h[pop_value] != s # 出栈的数据和入栈的是否是一对
      end
    end
    # 是否清空了栈
    stack.length == 0
  end


  # 模拟网页
  def self.look_page steps
    # 前进栈，后退栈
    # steps 为步骤 ->  1 为前进，2 为后退
    before = Stack.new([]) # 前进栈
    after = Stack.new([]) # 后退栈
    steps.each do |step|
      stack_value = rand(999999)
      if step == 1
        # 前进, 把之前的网页存储进可后退栈。
        after.push stack_value
        before.pop
      elsif step == 2
        # 后退 把后退的网页存储进可前进栈
        before.push stack_value
        after.pop
      end

    end

    pp "前进栈为 #{before.to_s}, 后退栈为 #{after.to_s}"
  end


end


stack = Stack.new([1,2,3])
# stack.pop
pp stack.to_s # 3 2 1
# 栈 后进先出。 增 删操作只能在末尾进行
# 入栈
stack.push 5 # 5 3 2 1
stack.push 6 # 6 5 3 2 1
# 出栈
stack.pop # 5 3 2 1

pp stack.to_s

# 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效
str_flag = Stack.check_str("{ } ( ) [ ] { } (")
pp str_flag ? "字符串合法":"字符串非法"

# 1 为前进， 2 为后退
Stack.look_page([1, 1, 1, 1, 2, 2, 1, 1, 1])