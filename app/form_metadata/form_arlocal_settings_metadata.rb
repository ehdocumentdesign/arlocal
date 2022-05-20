class FormArlocalSettingsMetadata


  extend FormMetadataUtils


  DATA = {
    admin: {
      navbar: 1,
      partial: 'form_admin',
      selectable: {
        :@albums_index_sorters => proc { SorterIndexAdminAlbums.options_for_select },
        :@audio_index_sorters => proc { SorterIndexAdminAudio.options_for_select },
        :@events_index_sorters => proc { SorterIndexAdminEvents.options_for_select },
        :@isrc_review_sorters => proc { SorterReviewAdminIsrc.options_for_select },
        :@keywords => proc { QueryKeywords.options_for_select_admin },
        :@pictures_index_sorters => proc { SorterIndexAdminPictures.options_for_select },
        :@videos_index_sorters => proc { SorterIndexAdminVideos.options_for_select },
        :@selectable_pictures_sorters => proc { SorterFormSelectablePictures.options_for_select }
      }
    },
    artist: {
      navbar: 1,
      partial: 'form_artist',
      selectable: {}
    },
    audio: {
      navbar: 1,
      partial: 'form_audio',
      selectable: {}
    },
    icon_attachment_purge: {
      navbar: nil,
      partial: 'form_icon_attachment_purge',
      selectable: {}
    },
    icon: {
      navbar: 1,
      partial: 'form_icon',
      selectable: {
        :@source_types => proc { ArlocalSettings.icon_source_type_options_for_select }
      }
    },
    marquee: {
      navbar: 1,
      partial: 'form_marquee',
      selectable: {
        :@markup_parsers => proc { MarkupParser.options_for_select }
      }
    },
    public: {
      navbar: 1,
      partial: 'form_public',
      selectable: {
        :@albums_index_sorters => proc { SorterIndexPublicAlbums.options_for_select },
        :@audio_index_sorters => proc { SorterIndexPublicAudio.options_for_select },
        :@events_index_sorters => proc { SorterIndexPublicEvents.options_for_select },
        :@pictures_index_sorters => proc { SorterIndexPublicPictures.options_for_select },
        :@videos_index_sorters => proc { SorterIndexPublicVideos.options_for_select },
        :@selectable_pictures_sorters => proc { SorterFormSelectablePictures.options_for_select }
      }
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :admin)
    pane = pane.to_s.downcase.to_sym

    if FormArlocalSettingsMetadata::DATA.has_key?(pane)
      form = FormArlocalSettingsMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormArlocalSettingsMetadata::DATA[:admin]
      current_pane = :admin
    end

    @current_pane = current_pane
    @navbar_categories = FormArlocalSettingsMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
