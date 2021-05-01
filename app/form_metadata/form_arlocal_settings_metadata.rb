class FormArlocalSettingsMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :admin)
    pane = ((pane == nil) ? :admin : pane.to_sym.downcase)

    @nav_categories = FormArlocalSettingsMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :admin,
      :artist,
      :audio,
      :html_head,
      :icon,
      :marquee,
      :public
    ]
  end



  private


  def determine_partial_name(pane)
    case pane
    when :admin
      'form_admin'
    when :artist
      'form_artist'
    when :audio
      'form_audio'
    when :html_head
      'form_html_head'
    when :icon
      'form_icon'
    when :icon_attachment_purge
      'form_icon_attachment_purge'
    when :marquee
      'form_marquee'
    when :public
      'form_public'
    else
      'form_admin'
    end
  end


  def determine_selectables(pane)
    FormArlocalSettingsMetadata::Selectables.new(pane)
  end


  def determine_tab_name(pane)
    if FormArlocalSettingsMetadata.categories.include?(pane)
      pane
    else
      :admin
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :albums_index_sorters,
      :audio_index_sorters,
      :events_index_sorters,
      :keywords,
      :markup_parsers,
      :pictures_index_sorters,
      :videos_index_sorters,
      :selectable_pictures_sorters,
      :source_types
    )
    def initialize(pane)
      case pane
      when :admin
        @albums_index_sorters = SorterIndexAdminAlbums.options_for_select
        @audio_index_sorters = SorterIndexAdminAudio.options_for_select
        @events_index_sorters = SorterIndexAdminEvents.options_for_select
        @keywords = QueryKeywords.options_for_select_admin
        @pictures_index_sorters = SorterIndexAdminPictures.options_for_select
        @videos_index_sorters = SorterIndexAdminVideos.options_for_select
        @selectable_pictures_sorters = SorterFormSelectablePictures.options_for_select
      when :icon
        @source_types = ArlocalSettings.icon_source_type_options_for_select
      when :marquee
        @markup_parsers = MarkupParser.options_for_select
      when :public
        @albums_index_sorters = SorterIndexPublicAlbums.options_for_select
        @audio_index_sorters = SorterIndexPublicAudio.options_for_select
        @events_index_sorters = SorterIndexPublicEvents.options_for_select
        @pictures_index_sorters = SorterIndexPublicPictures.options_for_select
        @videos_index_sorters = SorterIndexPublicVideos.options_for_select
        @selectable_pictures_sorters = SorterFormSelectablePictures.options_for_select
      end
    end
  end



end
