class VideoBuilder


  def default
    Video.new(params_default)
  end


  def default_with(params_given)
    params = params_default.merge(params_given)
    Video.new(params)
  end


  def params_default
    {
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      indexed: false,
      involved_people_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      published: false
    }
  end


end
