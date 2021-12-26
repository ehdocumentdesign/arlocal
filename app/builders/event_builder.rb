class EventBuilder


  attr_reader :event


  def initialize
    @event = Event.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.event
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.create(event_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(event_params)
    end
  end



  public


  def assign_default_attributes
    @event.assign_attributes(params_default)
  end


  def assign_given_attributes(event_params)
    @event.assign_attributes(event_params)
  end



  private


  def params_default
    {
      details_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      event_pictures_sorter_id: SorterEventPictures.find_by_symbol(:cover_manual_asc).id,
      indexed: true,
      show_can_cycle_pictures: true,
      show_can_have_more_pictures_link: true,
      title_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      title_text_markup: ''
    }
  end


end
