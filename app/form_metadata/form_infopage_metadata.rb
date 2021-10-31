class FormInfopageMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :article, settings: nil)
    pane = ((pane == nil) ? :infopage : pane.to_sym.downcase)

    @nav_categories = FormInfopageMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, settings)
    @tab_name = determine_tab_name(pane)
  end


  protected


  def self.categories
    [
      :infopage,
      :articles,
      :links,
      :pictures,
      :destroy
    ]
  end



  private


  def determine_partial_name(pane)
    case pane
    when :infopage
      'form'
    when :articles
      'form_articles'
    when :links
      'form_links'
    when :pictures
      'form_pictures'
    when :destroy
      'form_destroy'
    else
      'form'
    end
  end


  def determine_selectables(pane, settings)
    FormInfopageMetadata::Selectables.new(pane, settings)
  end


  def determine_tab_name(pane)
    if FormInfopageMetadata.categories.include?(pane)
      pane
    else
      :infopage
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :articles,
      :item_groups,
      :links,
      :pictures
    )
    def initialize(pane, settings)
      case pane
      when :infopage
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :articles
        @articles = Article.all
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :links
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
        @links = QueryLinks.options_for_select_admin
      when :pictures
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
        @pictures = QueryPictures.options_for_select_admin_with_nil(settings)
      else
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      end
    end
  end




end
