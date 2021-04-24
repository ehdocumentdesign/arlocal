class FormKeywordMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :keyword, arlocal_settings: nil)
    pane = ((pane == nil) ? :keyword : pane.to_sym.downcase)

    @nav_categories = FormKeywordMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, arlocal_settings)
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
      :videos,
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
    when :videos
      'form_videos'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane, arlocal_settings)
    FormKeywordMetadata::Selectables.new(pane, arlocal_settings)
  end


  def determine_tab_name(pane)
    if FormKeywordMetadata.categories.include?(pane)
      pane
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :albums,
      :audio,
      :events,
      :pictures,
      :videos
    )
    def initialize(pane, arlocal_settings)
      case pane
      when :albums
        @albums = QueryAlbums.options_for_select_admin
      when :audio
        @audio = QueryAudio.options_for_select_admin
      when :events
        @events = QueryEvents.options_for_select_admin
      when :pictures
        @pictures = QueryPictures.options_for_select_admin(arlocal_settings)
      when :videos
        @videos = QueryVideos.options_for_select_admin
      end
    end
  end



end
