class Product < ApplicationRecord
  # 默认英语匹配
  # stem_exclusion 排除某些词
  searchkick default_fields: [:name, :store_code, :full_description, :property_name] # language: "chinese"

  scope :search_import, -> {includes(:properties)}
  scope :default_order, -> {{_score: :desc,display_order: :desc}}

  #  关联表建索引
  def search_data
    {
        name: name,
        store_code: store_code,
        full_description: full_description,
        published: published,
        display_order: display_order,
        display_start_at: display_start_at,
        display_end_at:display_end_at,
        price: price,
        property_name: properties.map(&:name)}
  end

  # def search_data {name: name} # 对那些字段建立索引

  # ActiveRecord::HasManyThroughOrderError (Cannot have a has_many :through association 'Product#properties' which goes through 'Product#product_properties' before the through association is defined.): 必须在前 不然不能 through
  has_many :product_properties
  has_many :properties, through: :product_properties




  def self.new_products
    # 商品表
    # name 商品名
    # store code 商品代码
    # full description 商品详细描述
    # published 是否发表
    # display order 显示顺序
    # display start at 显示开始时间
    # display end at 显示结束时间
    # price 价格
    (1..100).each do |i|
      products = {name: "商品_#{i}", store_code: "code_#{i}", full_description: "描述_#{i}", published: i.odd? ? true : false,
                  display_order: i, display_start_at: Time.now, display_end_at: Time.now + i.day, price: rand(99999) }
      Product.create(products)

      ProductProperty.create(product_id: i, property_id: i)

    end
  end

  def self.get_conn params
    key = params[:search_all].present? ? params[:search_all] : "*"
    conn = {published: true, display_start_at: {gte: Time.now -  100.day}, display_end_at: {lte: Time.now +  100.day}}
    params[:page] ||= 1
    params[:per_page] ||= 20
    conn[:name] = {like: "%#{params[:name]}%"} if params[:name].present?
    conn[:store_code] = {like: "%#{params[:store_code]}%"} if params[:store_code].present?


    # 获取最大钱
    if params[:price_start].present? || params[:price_end].present?
      # preices = Product.search "*",order: {price: :desc}
      # max_price =  params[:price_end].present? ? params[:price_end] : preices.first.price
      # min_price = params[:price_start].to_i
      #
      # conn[:price] = (min_price..max_price.to_i).to_a
      #
      conn[:price] = {}

      conn[:price].merge!({gte: params[:price_start].to_i}) if params[:price_start].present?
      conn[:price].merge!({lte: params[:price_end].to_i}) if params[:price_end].present?

    end


    # if params[:price_start].present? || params[:price_end].present?
    #   # price_ranges = [{to: 20}, {from: 20, to: 50}, {from: 50}]
    #   # @products = Product.search "*",where: {name: "商品liym_1"}, aggs: {name: {}, store_code: {}, price: {ranges: price_ranges}}
    #
    #   price_ranges[:from] = params[:price_start].to_i if params[:price_start].present?
    #   price_ranges[:to] = params[:price_end].to_i  if params[:price_end].present?
    # end

    # 商品属性， 价格区间
    price_ranges = [{to: 99}, {from: 100, to: 199}, {from: 200}]
    # _score 匹配分数
    # 价格降序 order: {price: desc,_score: :desc,display_order: :desc} 价格升序  order: {price: asc,_score: :desc,display_order: :desc}
    # Elasticsearch获取所有内容 load: false
    Product.search key, where: conn,load: false, aggs: {property_name:{},price:  {ranges: price_ranges}}, order: {_score: :desc,display_order: :desc}, limit: 10, offset: 0
  end
end
