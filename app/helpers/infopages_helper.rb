module InfopagesHelper


  def infopage_admin_edit_nav_button(infopage: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_infopage_path(infopage.id, pane: category),
      target_pane: category
    )
  end


  def infopage_statement_articles_count(infopage)
    pluralize infopage.articles.count.to_i, 'article'
  end


  def infopage_statement_links_count(infopage)
    pluralize infopage.links.count.to_i, 'link'
  end


  def infopage_statement_pictures_count(infopage)
    pluralize infopage.pictures.count.to_i, 'picture'
  end


  def infopageable_reference_admin_link(infopage_item)
    case infopage_item.type_of
    when 'Article'
      article_reference_admin_link(infopage_item.infopageable)
    when 'Link'
      link_reference_admin_link(infopage_item.infopageable)
    when 'Picture'
      picture_reference_admin_link(infopage_item.infopageable)
    end
  end




end
