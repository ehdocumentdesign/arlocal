module ParsersHelper


  # parser_div() returns the html_class of the parser
  # therefore this method is not as easy to DRY up by calling parser_result from within
  def parser_div(resource_text_props)
    parser = MarkupParser.find(resource_text_props[:parser_id])
    text_markup = resource_text_props[:text_markup]
    parsed_text = parser.parse(text_markup)
    sanitized_text = sanitize(parsed_text)
    tag.div(sanitized_text, class: parser.html_class)
  end


  def parser_remove_markup(resource_text_props)
    strip_tags(parser_result(resource_text_props)).strip
  end


  # parser_result() is html-agnostic, it does not return a tag or a class
  # therefore this method is not as easy to DRY up by calling parser_div
  def parser_result(resource_text_props)
    parser = MarkupParser.find(resource_text_props[:parser_id])
    text_markup = resource_text_props[:text_markup]
    parsed_text = parser.parse(text_markup)
    sanitize(parsed_text)
  end


end
