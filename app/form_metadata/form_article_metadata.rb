class FormArticleMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :article, settings: nil)
    pane = ((pane == nil) ? :article : pane.to_sym.downcase)

    @nav_categories = FormArticleMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :article,
      :destroy
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :article
      'form'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables
    FormArticleMetadata::Selectables.new
  end


  def determine_tab_name(pane)
    if FormArticleMetadata.categories.include?(pane)
      pane
    else
      :article
    end
  end


  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :markup_parsers
    )
    def initialize
      @markup_parsers = MarkupParser.options_for_select
    end
  end


end
