class ArticleBuilder
  
    
  def default
    Article.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Article.new(params)
  end


  def params_default
    {
      indexed: true,
      parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      published: false
    }
  end

  
end