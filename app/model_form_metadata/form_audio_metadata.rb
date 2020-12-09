class FormAudioMetadata
  
  
  attr_reader :nav_categories, :partial_name, :selectables, :tab_name
  
  
  def initialize(pane: :audio)
    pane = ((pane == nil) ? :audio : pane.to_sym.downcase)
    
    @nav_categories = FormAudioMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end
  
  
  
  protected
  
  
  def self.categories
    [
      :audio,
      :albums,
      :events,
      :keywords,
      :id3,
      :attachment,
      :destroy
    ]
  end
  
  

  private
  
  
  def determine_partial_name(pane)
    case pane
    when :audio
      'form'
    when :albums
      'form_albums'
    when :events
      'form_events'
    when :keywords
      'form_keywords'
    when :id3
      'form_id3'
    when :attachment
      'form_attachment'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end
  
  
  def determine_selectables(pane)
    FormAudioMetadata::Selectables.new(pane)
  end
  
  
  def determine_tab_name(pane)
    if FormAudioMetadata.categories.include?(pane)
      pane
    else
      :audio
    end
  end
  
  
  
  class Selectables
    attr_reader(
      :albums,
      :events,
      :keywords,
      :markup_parsers
    )
    def initialize(pane)
      case pane
      when :albums
        @albums = QueryAlbums.new.order_by_title_asc
      when :audio
        @markup_parsers = MarkupParser.options_for_select
      when :events
        @events = QueryEvents.new.order_by_start_time_asc
      when :keywords
        @keywords = QueryKeywords.new.order_by_title_asc
      else 
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end  


  # class Selectors
  #   attr_reader(
  #     :albums,
  #     :keywords
  #   )
  #   def initialize
  #     @albums = QueryAlbums.new.order_by_title_asc
  #     @keywords = QueryKeywords.new.all_that_select_audio
  #   end
  # end
  
  
end
