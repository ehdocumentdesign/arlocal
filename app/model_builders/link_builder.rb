class LinkBuilder
  
    
  def default
    Link.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Link.new(params)
  end
  
  
  def params_default
    {
      details_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
    }
  end
  
    
end
