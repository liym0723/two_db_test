require 'es_query'
module ProductSearch
  extend ActiveSupport::Concern

  included do
    searchkick index_name: "#{self.name.tableize}_v1",
               callbacks: false,
               merge_mappings: true,
               mappings: {
        properties: {
            name: {type: 'text'},
            store_code: {type: 'keyword'},
            full_description: {type: 'text'},
            price: {type: 'integer'},
            display_order: {type: 'integer'},
            display_start_at: {type: 'date'},
            display_end_at: {type: 'date'},
            attributes: {
                properties: {
                    id: {type: 'integer'},
                    name: {type: 'text'}
                }
            }
        }
    }, settings: {
            index: {
                analysis: {
                    analyzer: :ik_smart,
                    tokenizer: :ik_max_word,
                }
            }
        }

    scope :search_import, -> { includes(:properties) }
  end

  def should_index?
    published
  end

  def search_data
    return {} if !should_index?
    {
        name: name.to_s,
        store_code: store_code,
        full_description: full_description.to_s,
        price: price.to_i,
        display_order: display_order.to_i,
        display_start_at: display_start_at,
        display_end_at: display_end_at,
        attributes: self.properties.pluck(:id, :name).map {|id, nm| {id: id, name: nm}}
    }
  end

  module ClassMethods

    def data_filter
      {display_start_at: {gte: Date.today}, display_end_at: {lte: Date.today}}
    end

    def search_by_elastic(params)
      keyword = params[:q].blank? ? '*' : params[:q]
      aggs = get_aggs

      mybody = search(keyword, fields: [], execute: false,
                 where: data_filter,
                 aggs: aggs,
                 misspellings: true,
                 order: [{_score: :desc}, {display_order: :desc}, {store_code: :asc}]
          ).body

      query = mybody.delete(:query)
      query[:bool][:must] = get_query(params)

      filters = get_filter(params)
      query[:bool][:filter] = query[:bool][:filter] + filters if filters.present?

      search( body: mybody.merge(query: query),
              page: params[:page],
              per_page: 100,
              includes: [:properties],
              )
    end

    #聚合
    def get_aggs
      price_ranges = [{to: 1500}, {from: 1500, to: 10000}, {from: 10000, to: 50000}, {from: 50000, to: 100000}, {from: 100000}]
      aggs = {price: {ranges: price_ranges}}
      aggs['attributes.id'] = {limit: 10}
      aggs
    end

    #过滤器（不影响查询结果的_score）
    def get_filter(params)
      filters = []
      #价格检索
      if params[:pf].present? || params[:pt].present?
        conn = {}
        conn[:gte] = params[:pf] if params[:pf].present?
        conn[:lte] = params[:pt] if params[:pt].present?
        filters << ::ESQuery.get_bool(must: true, where: {price: conn}) if conn.present?
      end
      #商品属性检索用and
      filters << ::ESQuery.get_bool(must: true, where: {'attributes.id' => params[:attr_id].map {|id| {term: id}} }) if params[:attr_id].present?

      filters
    end

    #查询条件（会影响查询结果的_score）
    def get_query(params)
      conn = []
      if (q = params[:q].to_s.strip).present?
        columns = ['name^5', 'attributes.name', :store_code, :full_description]
        queries = ::ESQuery.get_bool(where: {columns => q})
        conn << { dis_max: {queries: queries} } if queries.present?
      end

      detail_queries = params_queries(params)
      conn << detail_queries if detail_queries.present?

      { match_all: {} } if conn.blank?

      { bool: { must: conn } }
    end

    #详细字段检索
    def params_queries(params)
      queries = []
      #商品名查询
      if (pn = params[:pn].to_s.strip).present?
        queries << ::ESQuery.get_bool(where: {name: pn})
      end
      #store code查询
      if (sc = params[:sc].to_s.strip).present?
        queries << ::ESQuery.get_bool(where: {store_code: sc})
      end

      return if queries.blank?
      { bool: { must: queries }}
    end
  end
end
