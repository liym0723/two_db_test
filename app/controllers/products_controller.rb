class ProductsController < ApplicationController
        #
        # 1. 全部字段检索.
        # 2. products.name 检索
        # 3. products.price 范围区间检索
        # 4. products.store_code 检索
        # 5. 一览， 列出检索到的商品属性(件数), 件数排序, 只显示前10个. 点击属性使用属性检索，可以多个属性一起检索
        # 6. 一览, 显示价格区间(件数)， 点击区间 按照价格区间检索
        # 7. 排序: 默认排序 匹配分数 desc, display_order desc
        #    价格升序: price asc, 匹配分数 desc, display_order desc
        #    价格降序: price desc, 匹配分数 desc, display_order desc

  def index

    # Product.reindex
    # ProductProperty.reindex
    # Property.reindex
    # npm run start
    # Product.reindex # 数据添加到搜索索引
    # @products = Product.search("_1") # Searchkick::Results
    # @products = @products = Product.search "描述_1"
    # pp @products.total_count # 总数
    # pp @products.took # 花费时间， 毫秒为单位
    # pp @products.response # 完整回复

    # 检索的是全部字段中 包含 描述_1 的数据
    # fields: [{name: :exact}] 精准匹配
    # @products = @products = Product.search "描述",fields: [:name, :store_code], where: {published: true}, limit: 10, offset: 0, order: {id: :asc}
    #

    # 数据修改了之后， 还需要重新把数据给写进去

    # where: {
    #     expires_at: {gt: Time.now}, # 对于当前时间
    #     orders_count: 1..10, # 获取1 - 10以内
    #     id: [1,10], # ID  in (1,10)
    #     id: {not: 3}, # not 3
    #     id: {not: [22,21] }, # not in (22,21)
    #     id: {all: [1,3]}, # 数组离得全部元素
    #     or: [{xxx: true},{xxx: false}]
    # }
    # @products = Product.search "描述",where: {display_order: 1..10, _or: [{published: true}]} # TODO ID 不能区间


    # Product.search "wingtips", aggs: {size: {where: {color: "brandy"}}}
    # @products = Product.search "*", where: {name: "商品_2"}, aggs: {name: {where: {name: "商品_3"}}}, smart_aggs: false
    # price_rangs = [{price: [100,200]}]
    # @products = Product.search "*", aggs: {price: {where: {ranges: price_rangs}}}
    # pp @products.aggs

    #pp @products.response
    # 分页
   # @products = @products = Product.search "描述_1", page: 1, per_page: 2

    # id 不支持范围检索
    # load: false 获取所有字段内容
    # select: [:name] 只获取到指定字段
    # boost_by: [:price] 按照指定字段降序
    # 查询的字符串 默认需要全部匹配 " code 2 "  code s 2
      # 默认使用匹配策略 word 整个词
        # word 整个词   * 默认
        # ord_start 词开头
        # word_middle 任意部分   * 最匹配
        # word_end 字尾
        # text_start 文字开头
        # text_middle 文字任意
        # text_end 文字结束
    # operator: "or" -> 不需要全部匹配 "code 2" code or 2
    # fields: [{name: :exact}] 完全匹配
    # @products = Product.search "attribute1"

    # price_ranges = [{to: 20}, {from: 20, to: 50}, {from: 50}]
    # @products = Product.search "*",where: {name: "商品liym_1"}, aggs: {name: {}, store_code: {}, price: {ranges: price_ranges}}

    # 关联字段 直接 search_data 配置。 如何取就行了


    #@products = Product.search "*",load: false#,where: {property_name: "attribute1"}

    @products = Product.get_conn params


    #########################################################
    # ES 一些语法
    # 'http://localhost:9200/_cat/indices?v 查看当前节点所有的 index
    # 分组 -> type
    # found 查询成功
    # _source 返回原始记录
    # took -> 操作耗时
    # timed_out -> 是否超时
    # hits 命中的记录
    # _score 默认按照这个字段降序排列。 匹配程度

    # size -> 指定返回结果数量
    # from -> 指定位移，从几开始
    # {"xxx":"xx xx"} xx or xx
    # {}


    # must 所有的语句都必须匹配
    # must_not 所有的语句都不能匹配
    # should 至少有一个语句要匹配
    # term 精准值。

  end


end
