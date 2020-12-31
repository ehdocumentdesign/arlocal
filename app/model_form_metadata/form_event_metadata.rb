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
    when :keywords
      'form_keywords'
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
    else
      :event
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :audio,
      :event_picture_sorters,
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
      when :pictures
        @event_picture_sorters = SorterEventPictures.options_for_select
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
        @keywords = QueryKeywords.new.order_by_title_asc
      when :keywords
        @keywords = QueryKeywords.new.order_by_title_asc
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end


end
