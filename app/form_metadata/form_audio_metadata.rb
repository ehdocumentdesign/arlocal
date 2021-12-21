class FormAudioMetadata


  extend FormMetadataUtils


  DATA = {
    audio: {
      navbar: 0,
      partial: 'form',
      selectable: { :@markup_parsers => proc { MarkupParser.options_for_select } }
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
    keyword_join_single: {
      navbar: nil,
      partial: 'form_keyword_join_single',
      selectable: { :@keywords => proc { QueryKeywords.options_for_select_admin } }
    },
    keywords: {
      navbar: 1,
      partial: 'form_keywords',
      selectable: {}
    },
    id3: {
      navbar: 1,
      partial: 'form_id3',
      selectable: {}
    },
    source: {
      navbar: 1,
      partial: 'form_source',
      selectable: { :@source_types => proc { Audio.source_type_options_for_select } }
    },
    source_attachment_purge: {
      navbar: nil,
      partial: 'form_source_attachment_purge',
      selectable: {}
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :audio)
    pane = pane.to_s.downcase.to_sym

    if FormAudioMetadata::DATA.has_key?(pane)
      form = FormAudioMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormAudioMetadata::DATA[:audio]
      current_pane = :audio
    end

    @current_pane = current_pane
    @navbar_categories = FormAudioMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
