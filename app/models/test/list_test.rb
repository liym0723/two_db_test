require 'pp'
class ListTest
  List = Struct.new(:val, :next)
  # head 头  foot 尾
  attr_accessor :head, :foot

  def initialize (*values)
    values.each {|v| add(v)}
  end

  # 向末尾插入链表
  def add(v)
    return if v.nil?
    return if !query_curr(v).nil? # 如果已经存在也不插入
    list = List.new(v)
    if @foot.nil? # 如果链表为空 头和尾都是同一个
      @head = @foot = list
    else
      @foot.next = list # 尾结点的下一个设置为新节点
      @foot = list # 尾结点更新为新节点
    end
  end

  def to_s
    node = @head
    s = []
    while !node.nil?
      s << node.val
      node = node.next
    end
    s.join(' -> ')
  end


  def self.reverse_list list, previous = nil
    return if list.nil?
    # 1 -> 2 -> 3 -> 4
    # 1 <- 2 <- 3 <- 4
    current_list = list.next # 保存下一个节点
    list.next = previous # 下一个节点变成上一个节点
    if current_list
      reverse_list(current_list,list)
    else
      list
    end
  end


  def reverse
    return nil if self.nil?
    prev = nil # 上一个
    curr = @head # 当前

    # 直到最后一个结束
    while(curr != nil)
      temp = curr.next # 记录下一个
      curr.next = prev # 当前 变成 之前
      prev = curr # 上一个变成 当前
      curr = temp # 当前变成 下一个

    end
    temp = @head
    @head = @foot
    @foot = temp
    self
  end


  # # 查询 根据给定的val 查询出对应的list
  # def query value, prev = true
  #   list = nil
  #   curr = self.head
  #
  #   while(curr != nil && curr.val != value)
  #     list = curr if prev # 查询的是上一个
  #     curr = curr.next
  #     list = curr if !prev # 查询的是当前
  #   end
  #
  #   list # 返回的是查询到的上一个元素 方便给新增 删除用
  # end

  # 查找当前
  def query_curr value
    curr = @head
    while(curr != nil && curr.val != value)
      curr = curr.next
    end
    curr
  end

  # 查找上一个
  def query_perv value
    list = nil # 记录查找到的对象的值
    curr = @head
    while(curr != nil && curr.val != value)
      list = curr
      curr = curr.next
    end

    # 查找到了上一个
    (list != nil && list.next != nil && list.next.val == value) ? list : nil
  end



  # 新增 默认是尾部新增
  def insert value,insert_value = @foot.val
    # 新增数据
    list = query_curr insert_value
    return if list.nil?

    add_list = List.new(value)

    if list.next.nil?
      # 新增在尾巴
      @foot = add_list
      list.next = @foot
    else
      # 新增在中间
      prev_next = list.next
      list.next = add_list
      add_list.next = prev_next
    end

  end

  # 删除
  def destroy value
    prev_list = query_perv value
    curr_list = query_curr value

    # 不存在查找的对象
    if prev_list.nil? && curr_list.nil?

    end

    # 没有上一个节点，只有当前节点
    if prev_list.nil? && !curr_list.nil?
        # 判断有没有下一个节点
        if curr_list.next.nil?
          # 不存在下一个节点 。 只有一个节点的情况下
          @head = @foot = nil
        else
          # 删除的是第一个节点
          @head = curr_list.next
          curr_list.next = nil
        end
    end

    # 有当前节点 和 上一个节点
    if !prev_list.nil? && !curr_list.nil?
      # 删除的是否是尾节点
      if curr_list.next.nil?
        @foot = prev_list
        prev_list.next = nil
      else
        prev_list.next = curr_list.next
      end
    end

  end

end

# 创建链表
list = ListTest.new(1,2,3,4)
list.add(5)
#
#
# pp list.to_s
# pp "====================="

list.insert 6,3

pp list
pp "============================="

list.destroy 5

pp list


# 查询链表
# pp list.query_curr 8


# 新增链表
# 增加一个6 在1 后面
# list.insert(6,1)

# 删除链表
# list.destroy 5
# 反转链表
list.reverse
pp list
