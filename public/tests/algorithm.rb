require 'pp'
class Algorithm

  def initialize arr = ""
    @old_arr = arr
  end

  # 逆转输出数组 复杂度 O(n)
  def reverse_order
    new_arr = []
    # old_arr.each_with_index do |value,index|
    #   new_arr[index] = value
    # end
    @old_arr.each_with_index do |value,index|
      new_arr[@old_arr.length - index - 1] = value
    end
    pp " old_arr = #{@old_arr} reverse new_arr = #{new_arr} "
  end

  # 首尾替换 复杂度 O(n)
  def reverse_order2
    new_arr = [] # 记录下 打印的时候方便看

    ( @old_arr.length / 2).times do |i|
      tmp = @old_arr[i]
      new_arr[i] = @old_arr[@old_arr.length - i - 1]
      new_arr[@old_arr.length - i - 1] = tmp
    end
    pp " old_arr = #{@old_arr} reverse new_arr = #{new_arr} "


  end

  # 查找数组里面的最大值
  def max_value
    max_value = @old_arr[0]
    @old_arr[1..-1].each {|value| max_value = value if max_value < value}
    pp " #{@old_arr} max value = #{max_value} "
  end


  # 查找重复
  def max_repeat
    val_max = @old_arr[0] # 记录最大值
    tmp_count = 0 # 记录最大重复次数
    @old_arr.each_index  do |i|
      repeat_count = 0 # 当前重复的次数
      @old_arr.each_index  do |j|
       repeat_count += 1 if @old_arr[i] == @old_arr[j]
        if  repeat_count > tmp_count
          tmp_count = repeat_count
          val_max = @old_arr[i]
        end
      end
    end

    pp "arr #{@old_arr} max repeat = #{val_max}"
  end

  # 求合， 2,3,7元三种钱 凑100
  def hundred_count
    count = 0
    0.upto(100/7) do |i|
      0.upto(100 / 3) do |j|
        0.upto(100 / 2) do |k|
         count += 1 if (i * 7 + 3 * j + 2 * k == 100)
       end
     end
   end

    count2 = 0
    0.upto(100/7) do |i|
      0.upto(100 / 3) do |j|
        number = 100 - i * 7 - j * 3
        count2 += 1 if  number == 0 || (number > 0 && number % 2 == 0)
      end
    end
    pp "O(n 立方)2 元、3 元、7 元的货币，凑出 100 元的方法一共有 #{count} 种"
    pp "O(n 平方)2 元、3 元、7 元的货币，凑出 100 元的方法一共有 #{count2} 种"
  end


  def max_repeat2
      hash = {}
      @old_arr.each  do |v|
        if hash[v].nil?
          hash[v] = 1
        else
          hash[v] = hash[v] += 1
        end
      end
      max =  hash.sort{|v1,v2| v1[1] <=> v2[1]}.last
      pp "arr #{@old_arr} max repeat = #{max[0]}"
  end

end


Algorithm.new([1,2,3,4,5]).reverse_order
Algorithm.new([1,2,3,4,5,6]).reverse_order2
Algorithm.new([3,1,63,19,0,7]).max_value
Algorithm.new([1,5,3,5,3,6,5,4,2,1,4,4,5]).max_repeat
Algorithm.new().hundred_count
Algorithm.new([1,5,3,5,3,6,5,4,2,1,4,4,5]).max_repeat2



