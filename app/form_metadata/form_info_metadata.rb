class FormInfoMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :article, settings: nil)
    pane = ((pane == nil) ? :article : pane.to_sym.downcase)

    @nav_categories = FormInfoMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :article,
      :links,
      :picture
    ]
  end



  private


  def determine_partial_name(pane)
    case pane
    when :article
      'form_article'
    when :links
      'form_links'
    when :picture
      'form_picture'
    else
      'form_item'
    end
  end


  def determine_selectables(pane, settings)
    FormInfoMetadata::Selectables.new(pane, settings)
  end


  def determine_tab_name(pane)
    if FormInfoMetadata.categories.include?(pane)
      pane
    else
      :article
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :articles,
      :links,
      :pictures
    )
    def initialize(pane, settings)
      case pane
      when :article
        @articles = Article.all
      when :links
        @links = QueryLinks.options_for_select_admin
      when :picture
        @pictures = QueryPictures.options_for_select_admin_with_nil(settings)
      else
        @articles = Article.all
      end
    end
  end




end
