class StreamBuilder
  
  
  def default
    Stream.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Stream.new(params)
  end
  
    
  def params_default
    {
      description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id
    }
  end
  
  
end

