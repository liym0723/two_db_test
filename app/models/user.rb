class User < ApplicationRecord

  validates :name, :email, presence: true

  scope :default_order, -> {order(id: :asc)}
end
