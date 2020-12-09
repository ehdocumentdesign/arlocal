class FormPictureMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name
  
  
  def initialize(pane: :picture)
    pane = ((pane == nil) ? :picture : pane.to_sym.downcase)
    
    @nav_categories = FormPictureMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end
  
  
  
  protected
  
  
  def self.categories
    [
      :picture,
      :albums,
      :datetime,
      :events,
      :keywords,
      :attachment,
      :destroy
    ]
  end
  
  
  
  private
  
  
  def determine_partial_name(pane)
    case pane
    when :picture
      'form'
    when :albums
      'form_albums'
    when :datetime
      'form_datetime'
    when :events
      'form_events'
    when :keywords
      'form_keywords'
    when :attachment
      'form_attachment'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end
  
  
  def determine_selectables(pane)
    FormPictureMetadata::Selectables.new(pane)
  end
  
  
  def determine_tab_name(pane)
    if FormPictureMetadata.categories.include?(pane)
      pane
    else
      :picture
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
      when :picture
        @markup_parsers = MarkupParser.options_for_select
      when :albums
        @albums = QueryAlbums.new.order_by_title_asc
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
  #     :keywords
  #   )
  #   def initialize
  #     @keywords = QueryKeywords.new.all_that_select_admin_pictures
  #   end
  # end
  

end