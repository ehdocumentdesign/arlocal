class FormStreamMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :stream)
    pane = ((pane == nil) ? :stream : pane.to_sym.downcase)

    @nav_categories = FormStreamMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :stream,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :stream
      'form'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane)
    FormStreamMetadata::Selectables.new(pane)
  end


  def determine_tab_name(pane)
    if FormStreamMetadata.categories.include?(pane)
      pane
    else
      :stream
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :markup_parsers
    )
    def initialize(pane)
      case pane
      when :stream
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
