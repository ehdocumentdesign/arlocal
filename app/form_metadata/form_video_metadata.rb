class FormVideoMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  @@default_pane = :video


  def initialize(pane: :video, arlocal_settings: nil)
    pane = ((pane == nil) ? @@default_pane : pane.to_sym.downcase)

    @nav_categories = FormVideoMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, arlocal_settings)
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


  def determine_selectables(pane, arlocal_settings)
    FormVideoMetadata::Selectables.new(pane, arlocal_settings)
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
    def initialize(pane, arlocal_settings)
      case pane
      when :video
        @markup_parsers = MarkupParser.options_for_select
      when :keywords
        @keywords = QueryKeywords.options_for_select_admin
      when :source
        @source_types = Video.source_type_options_for_select
      when :thumbnail
        @pictures = QueryPictures.options_for_select_admin(arlocal_settings)
      else
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
