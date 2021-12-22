class FormPictureMetadata


  extend FormMetadataUtils


  DATA = {
    picture: {
      navbar: 0,
      partial: 'form',
      selectable: { :@markup_parsers => proc { MarkupParser.options_for_select } }
    },
    albums: {
      navbar: 1,
      partial: 'form_albums',
      selectable: { :@albums => proc { QueryAlbums.options_for_select_admin } }
    },
    datetime: {
      navbar: 1,
      partial: 'form_datetime',
      selectable: {}
    },
    events: {
      navbar: 1,
      partial: 'form_events',
      selectable: { :@events => proc { QueryEvents.options_for_select_admin } }
    },
    keywords: {
      navbar: 1,
      partial: 'form_keywords',
      selectable: { :@keywords => proc { QueryKeywords.options_for_select_admin } }
    },
    source: {
      navbar: 1,
      partial: 'form_source',
      selectable: { :@source_types => proc { Picture.source_type_options_for_select } }
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


  def initialize(pane: :picture, arlocal_settings: nil)
    pane = pane.to_s.downcase.to_sym

    if FormPictureMetadata::DATA.has_key?(pane)
      form = FormPictureMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormPictureMetadata::DATA[:picture]
      current_pane = :picture
    end

    @current_pane = current_pane
    @navbar_categories = FormPictureMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
