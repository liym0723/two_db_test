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

    # @products = Product.get_conn params
    @products = Product.get_body_conn params

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
    # bool 允许你在需要的时候组合其他语句

    # size -> 指定返回结果数量
    # from -> 指定位移，从几开始
    # {"xxx":"xx xx"} xx or xx
    # {}

    # must 所有的语句都必须匹配
    # must_not 所有的语句都不能匹配
    # should 至少有一个语句要匹配
    # term 精准值。
    # range 范围

    # ES 评分 以及 非评分都是啥意思
    # query 进行全文搜索 或者其它任何需要影响相关性的搜索，其他都用过滤(filters)
    # match_all 查询简单的 匹配所有文档，没有指定查询方式，就是默认的查询. 经常和 filter一起用。 、
    # _score 分值。 1 = 中性分值
    # match 标准查询
    # 精准查询的时候 filter 语句取代 query. filter会被缓存
    # multi_match: {query: , fields: [xx,xx]} 同时在多个字段执行相同的match查询
    # range 查询 -> 指定区间内的数字或时间 {range: {age: {gte: 20, lt: 30}}} gt 大于 gte 大于等于 lt 小于 lte 小于等于
    # term 精准匹配
    # terms 指定多值进行匹配。 {terms: {tag: [xxx,xxx,xxx]}}
    # exists missing 查询指定字段是否值。 {exists: {field: true}}
    # bool 多查询组合在一起
      # must 文档 必须匹配这些条件
      # must_not 必须不匹配这些条件
      # should 如果满足这些语句的任意语句 增加_score(匹配程度)
      # filter 必须匹配 (不评分，过滤模式进行) 对评分没贡献， 根据过滤标准来排除或包含文档
    # post and get
    # post 请求会附带 body, 提交数据
    # get 不能带 body, 获取数据
    # _source 对检索字段进行过滤
    # ES 和sql 概念对比
    # ES     索引   类型    文档
    # sql    数据库 表      行
    # keyword 直接建立反向索引， text 先分词，后建立反向索引


    # term 查询会将词作为词项，并在倒排序中进行全匹配。
    # match 先进行分词处理， 在将解析后的词项去查询。
    # match_phrase 句子查询
    #

    # query context
    # 执行时计算文档匹配程度
    {"query": {}}
    # filter context
    # 只关心是否匹配
    {"filter": {}}

    # 全文匹配。（text）
    # 针对text 类型全文检索。对查询语句先进行分词处理。 如 match, match_phrase(短句匹配), query
    # operator 指定匹配关系   or || and
    # minimum_should_match   指定匹配单词数
    {
        "query": {
            "match": {
                "full_description": {
                    "query": "描述_1 描述_3",
                    "operator": "or",
                    "minimum_should_match": "5"
                }
            }
        }
    }

    # 匹配词组查询  包含空格会连上
    {
        "query": {
            "match_phrase": {
                "name": {
                    "query": "商品liym_1  xx",
                    "slop": 1 # 匹配到几个单词就行
                }
            }
        }
    }

    # 单词匹配 （string）
    # 不对查询语句做分词处理， 直接去匹配字段倒序排序。 term(精准匹配), terms(多值精准匹配) range(范围)
    # exists(存在字段查询). 排除没有price字段，或者为null 但不会排除为""的字符串
    {"exists": {"field": "price"}}
    # 前缀查询
    {"prefix": {"address": "chi"}} # like 'chi%'
    # 通配符查询
    {"wildcard": {"address": "c*a"}}
    # 正则查询
    {"regexp": {"address": "chi.*a"}}
    # 相识度查询
    {"fuzzy": {"address": {"value": "cha", "fuzziness": 2}}} # fuzziness 单词之间的距离
    # ID 查询
    {"ids": {"type": "order", "values": [1,2,3]}}
    # 范围查询
    {"range": {"price":{"gte": 2, "lte": 10}}}
    # boost 联合filter 用。 手动指定 _score 分数
    {"boost": 2.5}

    # 查询字符串查询
    {
        "query": {
            "query_string": {
                "fields": [
                    "name",
                    "store_code",
                    "property_name"
                ],
                "query": "code_3 OR code_1"
            }
        }
    }

    {
        "query": {
            "simple_query_string": {
                "fields": [
                    "name",
                    "store_code",
                    "property_name"
                ],
                "query": "code_5 | attribute1" # | = 或, - = NOT ， + = AND
            }
        }
    }

    # Term Query
    # 将查询作为整个单词进行查询， 不分词查询


    # Bool Query
    # 多查询结果集 合并在一起
    {
        "query": {
            "bool": {
                "must": [ { # 符合全部的条件. 进行相关性算分
                            "match": {
                                "name": "商品liym_1"
                            }
                          },
                          {
                              "match": {
                                  "store_code": "code_1"
                              }
                          }],
                "must_not": {}, # 不符合全部的条件
                "should": [ # 可以符合should的任意条件。 （should and must, 可以不满足 should, 满足增加相关性得分）,（should 最少满足一个）。
                    {
                        "term": {
                            "name": "商品_5"
                        }
                    },
                    {
                        "term": {
                            "name": "商品_4"
                        }
                    },
                    {
                        "term": {
                            "name": "商品_3"
                        }
                    }
                ], "minimum_should_match": 1, # minimum_should_match 最少匹配几个. 联合should使用
                "filter": {} # 过滤符合文档的条件， 不计算相关性。
            }
        }
    }

    # 正则查询
    {
        "query": {
            "regexp": {
                "store_code": {
                    "value": ".*code..*",
                    "flags": "NONE"
                }
            }
        }
    }
    # 映射



    # 聚合
    # 先由倒序排序索引完成搜索，确定文档范文。 在由正序索引提取field, 最后做聚合计算，是最高效的
    # analyzed 分析器，分词

    # 桶分聚合
    # 对文档分组的操作
    # 指标聚合
    # 权值计算
    # 管道聚合
    # 对其他聚合操作的输出以及关联指标进行聚合


    # 查询平均价格
    {
        "query": {
            "term": {
                "published": true
            }
        },
        "aggs": { # 使用聚合
            "avgPrice": { # 自定义名字。
                "avg": { # avg 平均
                    "field": "price"
                }
            }
        },
        "size": 0 # 只需要指标聚合 不看数据
    }


    # pp @products.aggs
    # pp @products.response
  end



  def edit
    # 查询name = xx 和 name = xxx 的人
    {
        "query": {
            "terms": {
                "name": [
                    "商品_9",
                    "商品_99"
                ]
            }
        }
    }

    # 查询全部
    {
        "query": {
            "match_all": {}
        },
        "from": 0,
        "size": 3
    }

    # 分词检索(text)
    {
        "query": {
            "match": {
                "full_description": "描述_9"
            }
        }
    }

    # 分词检索多个字段
    {
        "query": {
            "multi_match": { # 选定多个字段所以使用multi_match
                "query": "描述_9",
                "fields": [ # 指定多个字段
                    "name",
                    "full_description"
                ]
            }
        }
    }

    # 片段匹配
    {
        "query": {
            "match_phrase": {
                "full_description": "描述_99"
            }
        }
    }

    # 前缀片段匹配
    {
        "query": {
            "match_phrase_prefix": {
                "full_description": "描述_9"
            }
        }
    }

    # 查找99块钱的人
    {
        "query": {
            "term": {
                "price": 99
            }
        }
    }

    # 查找有钱的人
    {
        "query": {
            "exists": {
                "field": "price"
            }
        }
    }

  end

end
