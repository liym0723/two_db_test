require 'pp'
class CustomizeArray
  # 07 | 数组：如何实现基于索引的查找？
  attr_accessor :arr
  def initialize *values
    @arr = values.flatten
  end

  # 数组新增操作
  # 默认在最后新增元素
  def add v,index = @arr.length
    arr_length = @arr.length
    # 在尾巴插入元素.如果进来的下标超过了最大下标
    if index >= arr_length
      @arr[arr_length] = v
    else

      # 待插入元素全部向后移动一位
      # arr[6] = arr[5], arr[5] = arr[4]
      while arr_length - 1 >= index
        @arr[arr_length] = @arr[arr_length - 1 ]
        arr_length -= 1
      end
      @arr[index] = v
    end
    @arr
  end

  # 数组删除操作
  def destroy index = @arr.length
    arr_length = @arr.length
    # 删除尾巴
    if index >= arr_length
      @arr[arr_length - 1] = nil
    else
      # 删除中间，全部的元素往前进一步
      # a[3] = a[4], a[4] = a[5]
      while index >= arr_length - 1
        @arr[index] = @arr[index + 1]
        index += 1
      end
      @arr[index] = nil
    end

    @arr.compact!
  end

  # 数组val去查找下标
  def query_by_val val
    @arr.each_with_index do |v,index|
      return "值#{val}的下标是#{index}" if v == val
    end

  end
  # 根据下标查找值
  def query_by_index index
    "#{index}下标的值是#{@arr[index]}"
  end

  # 案例 五个评分 去掉最高去掉最低 取平均
  def average
    sum = 0
    @arr.sort[1..-2].each{|score| sum+= score }
    pp "平均分是 #{sum / 3}"
  end

end



customize_array =  CustomizeArray.new(1,2,3,4,5)
pp customize_array.add(6) # 新增
# 在指定下标位置新增
pp customize_array.add(7,5) # 新增

pp customize_array.destroy 4
pp customize_array

pp customize_array.query_by_val 3
pp customize_array.query_by_index 2


# 五门成绩 去掉最高 去掉最低 取平均
customize_array2 = CustomizeArray.new(37,66,66,66,99)
customize_array2.average