class Blog < ApplicationRecord
  acts_as_nested_set # 启用嵌套集功能

  def self.tree_view(label_method = :to_s,  node = nil, level = -1)
    if node.nil?
      puts "root"
      nodes = Blog.roots
    else
      label = "|_ #{node.send(label_method)}"
      if level == 0
        puts " #{label}"
      else
        puts " |#{"    "*level}#{label}"
      end
      nodes = node.children
    end
    nodes.each do |child|
      tree_view(label_method, child, level+1)
    end
  end
end