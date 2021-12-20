class FormKeywordMetadata


  extend FormMetadataUtils


  DATA = {
    keyword: {
      navbar: 0,
      partial: 'form',
      selectable: {}
    },
    album_join_single: {
      navbar: nil,
      partial: 'form_album_join_single',
      selectable: { :@albums => proc { QueryAlbums.options_for_select_admin } }
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
      selectable: { :@audio => proc { QueryAudio.options_for_select_admin } }
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
      selectable: { :@events => proc { QueryEvents.options_for_select_admin } }
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
      selectable: { :@pictures => lambda { |arlocal_settings| QueryPictures.options_for_select_admin_with_nil(arlocal_settings) } }
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
      selectable: { :@videos => proc { QueryVideos.options_for_select_admin } }
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


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :keyword, arlocal_settings: QueryArlocalSettings.get)
    pane = pane.to_s.downcase.to_sym

    if FormKeywordMetadata::DATA.has_key?(pane)
      form = FormKeywordMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormKeywordMetadata::DATA[:keyword]
      current_pane = :keyword
    end

    @current_pane = current_pane
    @navbar_categories = FormKeywordMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable], arlocal_settings)
  end


end
