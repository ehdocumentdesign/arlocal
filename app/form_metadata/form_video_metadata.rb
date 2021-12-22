class FormVideoMetadata


  extend FormMetadataUtils


  DATA = {
    video: {
      navbar: 0,
      partial: 'form',
      selectable: { :@markup_parsers => proc { MarkupParser.options_for_select } }
    },
    keywords: {
      navbar: 1,
      partial: 'form_keywords',
      selectable: { :@keywords => proc { QueryKeywords.options_for_select_admin } }
    },
    picture: {
      navbar: 1,
      partial: 'form_picture',
      selectable: {}
    },
    picture_import: {
      navbar: nil,
      partial: 'form_picture_import',
      selectable: {}
    },
    picture_upload: {
      navbar: nil,
      partial: 'form_picture_upload',
      selectable: {}
    },
    picture_join_single: {
      navbar: nil,
      partial: 'form_picture_join_single',
      selectable: { :@pictures => lambda { |arlocal_settings| QueryPictures.options_for_select_admin_with_nil(arlocal_settings) } }
    },
    source: {
      navbar: 1,
      partial: 'form_source',
      selectable: { :@source_types => proc { Video.source_type_options_for_select } }
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :video, arlocal_settings: QueryArlocalSettings.get)
    pane = pane.to_s.downcase.to_sym

    if FormVideoMetadata::DATA.has_key?(pane)
      form = FormVideoMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormVideoMetadata::DATA[:video]
      current_pane = :video
    end

    @current_pane = current_pane
    @navbar_categories = FormVideoMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable], arlocal_settings)
  end


end
