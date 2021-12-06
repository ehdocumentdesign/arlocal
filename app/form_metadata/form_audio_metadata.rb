class FormAudioMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :audio)
    pane = (pane == nil ? :audio : pane).to_sym.downcase

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
      :source,
      :destroy
    ]
  end



  private


  def determine_partial_name(pane)
    case pane
    when :audio
      'form'
    when :album_join_single
      'form_album_join_single'
    when :albums
      'form_albums'
    when :event_join_single
      'form_event_join_single'
    when :events
      'form_events'
    when :keyword_join_single
      'form_keyword_join_single'
    when :keywords
      'form_keywords'
    when :id3
      'form_id3'
    when :source
      'form_source'
    when :source_attachment_purge
      'form_source_attachment_purge'
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
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :albums,
      :events,
      :keywords,
      :markup_parsers,
      :source_types
    )
    def initialize(pane)
      case pane
      when :album_join_single
        @albums = QueryAlbums.options_for_select_admin
      when :audio
        @markup_parsers = MarkupParser.options_for_select
      when :event_join_single
        @events = QueryEvents.options_for_select_admin
      when :keyword_join_single
        @keywords = QueryKeywords.options_for_select_admin
      when :source
        @source_types = Audio.source_type_options_for_select
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
