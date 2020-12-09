class FormAlbumMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :album, settings: nil)
    pane = ((pane == nil) ? :album : pane.to_sym.downcase)

    @nav_categories = FormAlbumMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
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
    when :keywords
      'form_keywords'
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


  def determine_selectables(pane, settings)
    FormAlbumMetadata::Selectables.new(pane, settings)
  end


  def determine_tab_name(pane)
    if FormAlbumMetadata.categories.include?(pane)
      pane
    else
      :album
    end
  end


  class Selectables
    attr_reader(
      :album_pictures_sorters,
      :audio,
      :keywords,
      :markup_parsers,
      :pictures_order_methods,
      :pictures
    )
    def initialize(pane, settings)
      case pane
      when :album
        @markup_parsers = MarkupParser.options_for_select
      when :audio
        @audio = QueryAudio.new.order_by_title_asc
        @keywords = QueryKeywords.new.order_by_title_asc
      when :pictures
        @album_pictures_sorters = SorterAlbumPictures.options_for_select
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
        @keywords = QueryKeywords.new.order_by_title_asc
      when :keywords
        @keywords = QueryKeywords.new.order_by_title_asc
      when :vendors
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
