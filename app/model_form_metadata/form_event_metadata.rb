class FormEventMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :event, settings: nil)
    pane = ((pane == nil) ? :event : pane.to_sym.downcase)

    @nav_categories = FormEventMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :event,
      :audio,
      :keywords,
      :pictures,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :event
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
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane, settings)
    FormEventMetadata::Selectables.new(pane, settings)
  end


  def determine_tab_name(pane)
    if FormEventMetadata.categories.include?(pane)
      pane
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :audio,
      :event_pictures_sorters,
      :keywords,
      :markup_parsers,
      :pictures
    )
    def initialize(pane, settings)
      case pane
      when :event
        @markup_parsers = MarkupParser.options_for_select
      when :audio
        @audio = QueryAudio.new.order_by_title_asc
        @keywords = QueryKeywords.new.order_by_title_asc
      when :audio_join_by_keyword
        @keywords = QueryKeywords.new.order_by_title_asc
      when :audio_join_single
        @audio = QueryAudio.new.order_by_title_asc
      when :keywords
        @keywords = QueryKeywords.new.order_by_title_asc
      when :picture_join_by_keyword
        @keywords = QueryKeywords.new.order_by_title_asc
      when :picture_join_single
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
      when :pictures
        @event_pictures_sorters = SorterEventPictures.options_for_select
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
        @keywords = QueryKeywords.new.order_by_title_asc
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end


end
