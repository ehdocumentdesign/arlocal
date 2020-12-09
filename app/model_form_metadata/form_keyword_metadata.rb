class FormKeywordMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name
  
  
  def initialize(pane: :keyword, settings: nil)
    pane = ((pane == nil) ? :keyword : pane.to_sym.downcase)
    
    @nav_categories = FormKeywordMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
    @tab_name = determine_tab_name(pane)
  end
  
  
  
  protected
  
  
  def self.categories
    [
      :keyword,
      :albums,
      :audio,
      :events,
      :pictures,
      :destroy
    ]
  end
  
  
  
  private
  
  
  def determine_partial_name(pane)
    case pane
    when :keyword
      'form'
    when :albums
      'form_albums'
    when :audio
      'form_audio'
    when :events
      'form_events'
    when :pictures
      'form_pictures'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end
  
  
  def determine_selectables(pane, settings)
    FormKeywordMetadata::Selectables.new(pane, settings)
  end
  
  
  def determine_tab_name(pane)
    if FormKeywordMetadata.categories.include?(pane)
      pane
    else
      :keyword
    end
  end



  class Selectables
    attr_reader(
      :albums,
      :audio,
      :events,
      :pictures
    )
    def initialize(pane, settings)
      case pane
      when :albums
        @albums = QueryAlbums.new.order_by_title_asc
      when :audio
        @audio = QueryAudio.new.order_by_title_asc
      when :events
        @events = QueryEvents.new.order_by_start_time_asc
      when :pictures
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
      end
    end
  end
    
  
  
end