require 'pp'
class ListNode
  attr_accessor :val, :next

  def initialize val
    @val = val
    @next = nil
  end

  def add_list new_list
    new_list.next = self.next unless self.next.nil? # 如果之前的节点不为空。则中间插入
    self.next = new_list # 变跟下一个节点为新增节点
  end

  def edit_list val
    self.val = val
  end

  def destroy_list

  end

  def query_list
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

end

# 构建一个链表
node1 = ListNode.new(32)


# 新增一个节点
node2 = node1.add_list(ListNode.new(11))
node3 =  node2.add_list(ListNode.new(88))
node4 = node2.add_list(ListNode.new(78))

pp node1
pp " 逆序后 ======================="
# 逆序节点
ListNode.reverse_list node1

pp node3

# 修改val
# node3.edit_list 1
