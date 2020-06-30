class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'   do |t|

      t.string :name, null: false
      t.string :content, null: false

      # awesome_nested_set
      t.integer :parent_id, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      # 以下はなくても動く
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0
    end
  end
end
