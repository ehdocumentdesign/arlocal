class FormAlbumMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :album, arlocal_settings: nil)
    pane = ((pane == nil) ? :album : pane.to_sym.downcase)

    @nav_categories = FormAlbumMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, arlocal_settings)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :album,
      :audio,
      :keywords,
      :pictures,
      :vendors,
      :destroy
    ]
  end



  private


  def determine_partial_name(pane)
    case pane
    when :album
      'form'
    when :audio
      'form_audio'
    when :audio_import
      'form_audio_import'
    when :audio_upload
      'form_audio_upload'
    when :audio_join_by_keyword
      'form_audio_join_by_keyword'
    when :audio_join_single
      'form_audio_join_single'
    when :keyword_join_single
      'form_keyword_join_single'
    when :keywords
      'form_keywords'
    when :picture_import
      'form_picture_import'
    when :picture_upload
      'form_picture_upload'
    when :picture_join_by_keyword
      'form_picture_join_by_keyword'
    when :picture_join_single
      'form_picture_join_single'
    when :pictures
      'form_pictures'
    when :vendors
      'form_vendors'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane, arlocal_settings)
    FormAlbumMetadata::Selectables.new(pane, arlocal_settings)
  end


  def determine_tab_name(pane)
    if FormAlbumMetadata.categories.include?(pane)
      pane
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils

    attr_reader(
      :album_pictures_sorters,
      :audio,
      :keywords,
      :markup_parsers,
      :pictures_order_methods,
      :pictures
    )

    def initialize(pane, arlocal_settings)
      case pane
      when :album
        @markup_parsers = MarkupParser.options_for_select
      # when :audio
        # @audio = QueryAudio.options_for_select_admin
        # @keywords = QueryKeywords.options_for_select_admin
      when :audio_join_by_keyword
        @keywords = QueryKeywords.options_for_select_admin
      when :audio_join_single
        @audio = QueryAudio.options_for_select_admin
      when :keyword_join_single
        @keywords = QueryKeywords.options_for_select_admin
      when :picture_join_by_keyword
        @keywords = QueryKeywords.options_for_select_admin
      when :picture_join_single
        @pictures = QueryPictures.options_for_select_admin_with_nil(arlocal_settings)
      when :pictures
        @album_pictures_sorters = SorterAlbumPictures.options_for_select
        @pictures = QueryPictures.options_for_select_admin_with_nil(arlocal_settings)
        @keywords = QueryKeywords.options_for_select_admin
      # when :keywords
        # @keywords = QueryKeywords.options_for_select_admin
      when :vendors
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
