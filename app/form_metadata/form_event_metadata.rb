class FormEventMetadata


  extend FormMetadataUtils


  DATA = {
    event: {
      navbar: 0,
      partial: 'form',
      selectable: { :@markup_parsers => proc { MarkupParser.options_for_select } }
    },
    audio_import: {
      navbar: nil,
      partial: 'form_audio_import',
      selectable: {}
    },
    audio_join_by_keyword: {
      navbar: nil,
      partial: 'form_audio_join_by_keyword',
      selectable: { :@keywords => proc { QueryKeywords.options_for_select_admin } }
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
    picture_import: {
      navbar: nil,
      partial: 'form_picture_import',
      selectable: {}
    },
    picture_join_by_keyword: {
      navbar: nil,
      partial: 'form_picture_join_by_keyword',
      selectable: { :@keywords => proc { QueryKeywords.options_for_select_admin } }
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
      selectable: { :@event_pictures_sorters => proc { SorterEventPictures.options_for_select } }
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :event, arlocal_settings: QueryArlocalSettings.get)
    pane = pane.to_s.downcase.to_sym

    if FormEventMetadata::DATA.has_key?(pane)
      form = FormEventMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormEventMetadata::DATA[:event]
      current_pane = :event
    end

    @current_pane = current_pane
    @navbar_categories = FormEventMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable], arlocal_settings)
  end


end
