module ParsersHelper


  def parser_div(resource_text_props)
    parser_result(resource_text_props, wrap_with: :div)
  end


  def parser_result(resource_text_props, html_class: nil, wrap_with: nil)
    parser_result = MarkupParser.parse_sanitize_class(resource_text_props)
    case wrap_with
    when :div
      content_tag(wrap_with, parser_result[:sanitized_text], class: parser_result[:html_class])
    when nil
      parser_result[:sanitized_text]
    end
  end





  # # parser_div() returns the html_class of the parser
  # # therefore this method is not as easy to DRY up by calling parser_result from within
  # def parser_div(resource_text_props)
  #   parser = MarkupParser.find(resource_text_props[:parser_id])
  #   parsed_text = parser.parse(resource_text_props[:text_markup])
  #   sanitized_text = sanitize(parsed_text)
  #   tag.div(sanitized_text, class: parser.html_class)
  # end
  #
  #
  # def parser_remove_markup(resource_text_props)
  #   strip_tags(parser_result(resource_text_props)).strip
  # end
  #
  #
  # # parser_result() is html-agnostic, it does not return a tag or a class
  # # therefore this method is not as easy to DRY up by calling parser_div
  # def parser_result(resource_text_props)
  #   parser = MarkupParser.find(resource_text_props[:parser_id])
  #   parsed_text = parser.parse(resource_text_props[:text_markup])
  #   sanitize(parsed_text)
  # end
  #



end
