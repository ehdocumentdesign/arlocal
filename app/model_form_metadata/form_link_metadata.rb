class FormLinkMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :link)
    pane = ((pane == nil) ? :link : pane.to_sym.downcase)

    @nav_categories = FormLinkMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :link,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :link
      'form'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane)
    FormLinkMetadata::Selectables.new(pane)
  end


  def determine_tab_name(pane)
    if FormLinkMetadata.categories.include?(pane)
      pane
    else
      :link
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :markup_parsers
    )
    def initialize(pane)
      case pane
      when :link
        @markup_parsers = MarkupParser.options_for_select
      end
    end
  end



end
