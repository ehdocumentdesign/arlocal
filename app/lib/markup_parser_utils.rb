module MarkupParserUtils
  
  
  def reset_parser_ids(resource, new_value)
    case new_value
    when Integer
      new_parser_id = new_value
    when String
      new_parser_id = new_value.to_i
    when Symbol
      new_parser_id = MarkupParser.find_by_symbol(new_value).id
    else
      new_parser_id = new_value.to_i
    end
    
    new_attributes = {}
    resource_parser_ids = resource.attributes.select { |k,v| k =~ /parser_id\z/ }
    resource_parser_ids.each_pair do |k,v|
      new_attributes[k] = new_parser_id
    end
    
    resource.update(new_attributes)
  end
    
    
end