class EventBuilder
  
  
  def default
    Event.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Event.new(params)
  end
  
  
  def params_default
    {
      details_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      event_pictures_sorter_id: SorterEventPictures.find_by_symbol(:cover_manual_asc).id,
      indexed: true,
      show_can_cycle_pictures: true,
      show_can_have_more_pictures_link: true
    }
  end
  
    
end
