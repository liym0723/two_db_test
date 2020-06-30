class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :parent_id, :integer, index: true # 用于保留位置整数的列
    add_column :users, :lft, :integer, index: true # 左边界数据
    add_column :users, :rgt, :integer, index: true # 有边界数据


    add_column :users, :depth, :integer, null: false, default: 0 # 深度数据默认值的列名
    add_column :users, :children_count, :integer, null: false, default: 0
  end
end
