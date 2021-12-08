class FormInfopageMetadata


  attr_reader :nav_categories, :partial_name, :selectables, :tab_name


  def initialize(pane: :infopage, arlocal_settings: nil)
    pane = ((pane == nil) ? :infopage : pane.to_sym.downcase)

    @nav_categories = FormInfopageMetadata.categories
    @partial_name = determine_partial_name(pane)
    @selectables = determine_selectables(pane, arlocal_settings)
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
    when :article_join_single
      'form_article_join_single'
    when :articles
      'form_articles'
    when :link_join_single
      'form_link_join_single'
    when :links
      'form_links'
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


  def determine_selectables(pane, arlocal_settings)
    FormInfopageMetadata::Selectables.new(pane, arlocal_settings)
  end


  def determine_tab_name(pane)
    if FormInfopageMetadata.categories.include?(pane)
      pane
    end
  end



  class Selectables
    include FormMetadataSelectablesUtils
    attr_reader(
      :articles,
      :item_groups,
      :keywords,
      :links,
      :pictures
    )
    def initialize(pane, arlocal_settings)
      case pane
      when :infopage
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :article_join_single
        @articles = Article.all
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :articles
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :link_join_single
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
        @links = QueryLinks.options_for_select_admin
      when :links
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      when :picture_join_by_keyword
        @keywords = QueryKeywords.options_for_select_admin
      when :picture_join_single
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
        @pictures = QueryPictures.options_for_select_admin_with_nil(arlocal_settings)
      when :pictures
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      else
        @item_groups = InfopageItem.group_options.sort_by{ |o| o[:order] }.map { |o| [o[:position], o[:id]] }
      end
    end
  end




end
