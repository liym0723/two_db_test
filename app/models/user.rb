class User < ApplicationRecord
  acts_as_nested_set :counter_cache => :children_count # 启用嵌套集功能

  validates :name, :email, presence: true

  scope :default_order, -> {order(id: :asc)}

end
