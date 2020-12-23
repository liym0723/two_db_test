module ESQuery

  def get_bool(options={})
    return nil if options[:where].blank?

    options[:nested] = false if options[:nested].nil?
    options[:must] = false if options[:must].nil?

    bools = []
    options[:where].each do |key, value|
      next if value.blank?
      if key.is_a?(Array)
        key.each do |k|
          bools << get_match(k, value)
        end
      elsif value.is_a?(Array)
        value.each do |v|
          bools << get_match(key, v)
        end
      else
        bools << get_match(key, value)
      end
    end
    bools.compact!

    return nil if bools.blank?

    if options[:nested]
      { nested: { path: options[:path], score_mode: 'sum', query: {
          function_score: {
              boost_mode: 'replace',
              query: { bool: { must: bools.flatten } }
          }
      }}}
    elsif options[:must]
      { bool: { must: bools.flatten } }
    else
      { bool: { should: bools.flatten } }
    end
  end

  def get_match(column, values)
    if values.is_a?(Hash)
      values.map do |key, val|
        case key
        when :gt
          {range: { column => { from: val, include_lower: false } } }
        when :gte
          {range: { column => { from: val, include_lower: true } } }
        when :lt
          {range: { column => { to: val, include_lower: false } } }
        when :lte
          {range: { column => { to: val, include_lower: true } } }
        when :term
          {term: {column => val}}
        when :in, :terms
          {terms: {column => val}}
        when :between
          range = {}
          range[:gte] = val[0] if val[0].present?
          range[:lte] = val[1] if val[1].present?
          return nil if range.blank?
          { range: { column => range } }
        end
      end
    else
      shoulds = [{ match_phrase: { column => { query: values, slop:  5 } } }]
      # https://www.elastic.co/guide/cn/elasticsearch/guide/current/multi-match-query.html
      shoulds << { multi_match: { query: values, fields:  column, minimum_should_match: '100%' } }#提高全匹配的分数
      shoulds << { multi_match: { query: values, fields:  column, minimum_should_match: '2<75% 6<50%' } }
      # https://www.elastic.co/guide/cn/elasticsearch/guide/current/_wildcard_and_regexp_queries.html
      shoulds << { wildcard: { column => values } }#提高全匹配的分数
      shoulds << { wildcard: { column => "*#{values}*" } }
      { bool: { should: shoulds } }
    end
  end
  module_function :get_bool, :get_match


end