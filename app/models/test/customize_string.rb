require 'pp'
class CustomizeString
  # 08 | 字符串：如何正确回答面试中高频考察的字符串匹配算法？
  attr_accessor :str
  def initialize val
    @str = val
  end

  # 字符串的新增
  def add son_string,index = @str.length
    # 默认增加在末尾
    if index >= @str.length
      @str += son_string
    else
      @str = "#{@str[0,index]}#{son_string}#{@str[index..-1]}"
    end
  end

  # 字符串的删除
  def destroy son_string
    @str.delete son_string
  end
  # 字符串的查找
  def queue son_string
    @str[son_string.to_s].nil? ? "不存在对应的字符串":"找到了对应的字符串"
  end

  # 字符串匹配查找
  def match_str son_string
    str_length = @str.length
    str_length.times do |i|
      return false if (str_length - i) < son_string.length # 剩余的长度都不够子串的长度 就不需要进行匹配了
      return true if @str[i,son_string.length] == son_string # 取出长度相应的串 进行匹配
    end

  end
  # 案例: 字符串匹配算法 同时出现在 a 和 b 中的最长子串
  def query_max_str son_string
    # 查找出两个字符串的最大公共字串。
    # abdc, badc

    # a 找到 a, 在匹配后续, ab = ad? 不等于就放弃 继续找a 等于在继续往下找一个
    max_number = 0 # 出现相同的最大次数
    max_str = "" # 相同的字符串
    @str.length.times do |i|
      son_string.length.times do |j|
        if @str[i] == son_string[j]
          # 如果第一个字符相同了,那么继续下一个 直到不一样了
           m = i
           n = j

          while m <= @str.length && n <= son_string.length && @str[m] == son_string[n]
            if max_number < (m - i + 1)
              max_number = m - i + 1
              max_str = @str[i..(m + 1)]
            end
            m += 1
            n += 1
          end
        end
      end
    end

    pp "最大长度是#{max_number},最大的串是#{max_str}"
  end

  # 翻转字符串中的每个单词 例如，输入: "the sky is blue"，输出: "blue is sky the"。
  def sort_str
    @str.split(" ").reverse.join(" ")
  end
end

string = CustomizeString.new("liym test 123")
pp string.match_str("test1")

string.query_max_str("li1est 312")
#
# pp string.sort_str
#
# pp string
# pp string.destroy("123")
# pp string.queue("123")

pp string

string.add(" 456 ",13)
pp string.str