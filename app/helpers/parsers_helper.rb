module ParsersHelper


  def parser_div(resource_text_props)
    parser_result(resource_text_props, wrap_with: :div)
  end


  def parser_remove_markup(resource_text_props)
    strip_tags(parser_result(resource_text_props))
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


end
