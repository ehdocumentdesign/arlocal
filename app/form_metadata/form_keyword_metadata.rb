class FormKeywordMetadata


  DATA = {
    keyword: {
      navbar: 0,
      partial: 'form',
      selectable: {}
    },
    album_join_single: {
      navbar: nil,
      partial: 'form_album_join_single',
      selectable: { albums: proc { QueryAlbums.options_for_select_admin } }
    },
    albums: {
      navbar: 1,
      partial: 'form_albums',
      selectable: {}
    },
    audio_import: {
      navbar: nil,
      partial: 'form_audio_import',
      selectable: {}
    },
    audio_join_single: {
      navbar: nil,
      partial: 'form_audio_join_single',
      selectable: { audio: proc { QueryAudio.options_for_select_admin } }
    },
    audio_upload: {
      navbar: nil,
      partial: 'form_audio_upload',
      selectable: {}
    },
    audio: {
      navbar: 1,
      partial: 'form_audio',
      selectable: {}
    },
    event_join_single: {
      navbar: nil,
      partial: 'form_event_join_single',
      selectable: { albums: proc { QueryEvents.options_for_select_admin } }
    },
    events: {
      navbar: 1,
      partial: 'form_events',
      selectable: {}
    },
    picture_import: {
      navbar: nil,
      partial: 'form_picture_import',
      selectable: {}
    },
    picture_join_single: {
      navbar: nil,
      partial: 'form_picture_join_single',
      selectable: { audio: lambda { |arlocal_settings| QueryPictures.options_for_select_admin_with_nil(arlocal_settings) } }
    },
    picture_upload: {
      navbar: nil,
      partial: 'form_picture_upload',
      selectable: {}
    },
    pictures: {
      navbar: 1,
      partial: 'form_pictures',
      selectable: {}
    },
    video_join_single: {
      navbar: nil,
      partial: 'form_video_join_single',
      selectable: { albums: proc { QueryEvents.options_for_select_admin } }
    },
    videos: {
      navbar: 1,
      partial: 'form_videos',
      selectable: {}
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :keyword, arlocal_settings: nil)
    pane = ((pane == nil) ? :keyword : pane.to_sym.downcase)

    @nav_categories = FormKeywordMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, arlocal_settings)
    @tab_name = determine_tab_name(pane)
  end



  protected


  def self.navbar_categories
    DATA.select{ |k,v| v[:navbar] != nil }.sort_by{ |k,v| v[:navbar] }.map{ |k,v| k }
  end


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
    when :album_join_single
      'form_album_join_single'
    when :albums
      'form_albums'
    when :audio_import
      'form_audio_import'
    when :audio_join_single
      'form_audio_join_single'
    when :audio_upload
      'form_audio_upload'
    when :audio
      'form_audio'
    when :event_join_single
      'form_event_join_single'
    when :events
      'form_events'
    when :picture_import
      'form_picture_import'
    when :picture_join_single
      'form_picture_join_single'
    when :picture_upload
      'form_picture_upload'
    when :pictures
      'form_pictures'
    when :video_join_single
      'form_video_join_single'
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
      when :album_join_single
        @albums = QueryAlbums.options_for_select_admin
      when :albums
      when :audio_join_single
        @audio = QueryAudio.options_for_select_admin
      when :audio
      when :event_join_single
        @events = QueryEvents.options_for_select_admin
      when :events
      when :picture_join_single
        @pictures = QueryPictures.options_for_select_admin_with_nil(arlocal_settings)
      when :pictures
      when :videos
        @videos = QueryVideos.options_for_select_admin
      end
    end
  end



end
