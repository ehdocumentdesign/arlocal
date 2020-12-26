module AttributeHelper


  def attribute_parser_id(attribute)
    attribute.to_s.concat('_parser_id').to_sym
  end


  def attribute_text_markup(attribute)
    attribute.to_s.concat('_text_markup').to_sym
  end


end
