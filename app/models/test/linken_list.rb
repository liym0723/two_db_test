require 'pp'
class LinkenList
  Node = Struct.new(:val, :next)
  attr_accessor :head, :foot

  def initialize (*values)
    values.each {|v| add(v)}
  end

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
    perv = nil
    curr = @head
    while(curr != nil && curr.val != value)
      perv = curr
      curr = curr.next
    end
    (perv != nil && perv.next != nil && perv.next.val == value ) ? perv : nil
  end

  # 新增在尾巴
  def add v
    return if v.nil?
    return if !(query_curr(v).nil?) # 存在就不加进去了
    node = Node.new(v)
    if @foot.nil? # 空链表
      @head = @foot = node
    else
      @foot.next = node
      @foot = node
    end
  end

  # 反转链表
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


  # 根据下标插入数据
  def insert_by_index value,index
    return if query_curr(value) != nil # 如果要插入的值,已经存在也不插入
    node = Node.new(value)
    if @foot.nil?
      # 往空链表里插入数据
      @head = @foot = node
    else
      # 有数据的链表插入数据
      curr = @head
      prev = nil
      index.times do |i|
        prev = curr
        curr = curr.next
        break if prev.next.nil?
      end
      if prev.nil? # 头插入
        node.next = curr
        @head = node
      elsif curr.nil? # 尾插入
        prev.next = node
        @foot = node
      else # 中间插入
        prev.next = node
        node.next = curr
      end

    end

  end


  # 根据 val 去插入数据
  def insert_by_val value,insert_value = @foot.val
    return if query_curr(value) != nil # 如果要插入的值,已经存在也不插入
    node = query_curr insert_value
    return if node.nil? # 如果要插入的位置不存在，那么不插入

    add_node = Node.new(value)

    if node.next.nil?
      # 新增在尾巴
      @foot = add_node
      node.next = @foot
    else
      # 新增在中间
      prev_next = node.next
      node.next = add_node
      add_node.next = prev_next
    end
  end

  # 删除
  def destroy value
    prev_node = query_perv value
    curr_node = query_curr value

    # 不存在查找的对象
    if prev_node.nil? && curr_node.nil?

    end

    # 没有上一个节点，只有当前节点
    if prev_node.nil? && !curr_node.nil?
      # 判断有没有下一个节点
      if curr_node.next.nil?
        # 不存在下一个节点 。 只有一个节点的情况下
        @head = @foot = nil
      else
        # 删除的是第一个节点
        @head = curr_node.next
        curr_node.next = nil
      end
    end

    # 有当前节点 和 上一个节点
    if !prev_node.nil? && !curr_node.nil?
      # 删除的是否是尾节点
      if curr_node.next.nil?
        @foot = prev_node
        prev_node.next = nil
      else
        prev_node.next = curr_node.next
      end
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
end




linken_list = LinkenList.new(1,2,3,4)

# 增
linken_list.add(5)

linken_list.insert_by_val(9,4) # 在 val为4的 后面插入 9
pp linken_list.to_s

linken_list.insert_by_index(8,1) # 在下标为1的地方 插入 8
pp linken_list.to_s
# 删

linken_list.destroy 2
pp linken_list.to_s

# 查

pp linken_list.query_curr(3)

pp linken_list.query_perv(3)


# 反转
pp linken_list.to_s
linken_list.reverse
pp linken_list.to_s
