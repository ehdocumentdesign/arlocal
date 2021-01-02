class FormVideoMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  @@default_pane = :video


  def initialize(pane: :video, settings: nil)
    pane = ((pane == nil) ? @@default_pane : pane.to_sym.downcase)

    @nav_categories = FormVideoMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :video,
      :keywords,
      :source,
      :thumbnail,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :video
      'form'
    when :keywords
      'form_keywords'
    when :source
      'form_source'
    when :thumbnail
      'form_thumbnail'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane, settings)
    FormVideoMetadata::Selectables.new(pane, settings)
  end


  def determine_tab_name(pane)
    if FormVideoMetadata.categories.include?(pane)
      pane
    else
      :video
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :markup_parsers,
      :keywords,
      :pictures,
      :source_types
    )
    def initialize(pane, settings)
      case pane
      when :video
        @markup_parsers = MarkupParser.options_for_select
      when :keywords
        @keywords = QueryKeywords.new.order_by_title_asc
      when :source
        @source_types = Video.source_type_options_for_select
      when :thumbnail
        @pictures = QueryPictures.new(arlocal_settings: settings).action_admin_forms_selectable_pictures
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
