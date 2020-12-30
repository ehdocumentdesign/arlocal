class FormVideoMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :video)
    pane = ((pane == nil) ? :video : pane.to_sym.downcase)

    @nav_categories = FormVideoMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :video,
      :thumbnail,
      :source,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :video
      'form'
    when :thumbnail
      'form_thumbnail'
    when :source
      'form_source'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane)
    FormVideoMetadata::Selectables.new(pane)
  end


  def determine_tab_name(pane)
    if FormVideoMetadata.categories.include?(pane)
      pane
    else
      :video
    end
  end


  class Selectables
    attr_reader(
      :markup_parsers
    )
    def initialize(pane)
      case pane
      when :video
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
