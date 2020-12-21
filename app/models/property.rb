class Property < ApplicationRecord
  searchkick

  has_many :product_properties # 必须在前 不然不能 through
  has_many :products, through: :product_properties


  def self.new_property
    # 属性表
    # name

    (1..100).each do |i|
      Property.create(name: "属性_#{i}")
    end

  end


end
