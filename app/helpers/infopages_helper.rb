module InfopagesHelper


  def infopage_admin_button_to_done_editing(infopage)
    button_admin_to_done_editing admin_infopage_path(infopage.id_admin)
  end


  def infopage_admin_button_to_edit(infopage)
    button_admin_to_edit edit_admin_infopage_path(infopage.id_admin)
  end


  def infopage_admin_button_to_edit_next(infopage, arlocal_settings: nil, target_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, target_pane)
      target_link = edit_admin_infopage_path(infopage.id_admin, pane: target_pane)
    else
      target_link = edit_admin_infopage_path(infopage.id_admin)
    end
    button_admin_to_next(target_link)
  end


  def infopage_admin_button_to_edit_previous(infopage, arlocal_settings: nil, target_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, target_pane)
      target_link = edit_admin_infopage_path(infopage.id_admin, pane: target_pane)
    else
      target_link = edit_admin_infopage_path(infopage.id_admin)
    end
    button_admin_to_previous(target_link)
  end


  def infopage_admin_button_to_index
    button_admin_to_index admin_infopages_path
  end


  def infopage_admin_button_to_new
    button_admin_to_new new_admin_infopage_path
  end


  def infopage_admin_button_to_next(infopage)
    button_admin_to_next admin_infopage_path(infopage.id_admin)
  end


  def infopage_admin_button_to_previous(infopage)
    button_admin_to_previous admin_infopage_path(infopage.id_admin)
  end


  def infopage_admin_edit_nav_button(infopage: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_infopage_path(infopage.id_admin, pane: category),
      target_pane: category
    )
  end


  def infopage_article_admin_button_to_new_join_single(infopage)
    button_admin_to_new_join_single edit_admin_infopage_path(infopage.id_admin, pane: :article_join_single)
  end


  def infopage_link_admin_button_to_new_join_single(infopage)
    button_admin_to_new_join_single edit_admin_infopage_path(infopage.id_admin, pane: :link_join_single)
  end



  def infopage_picture_admin_button_to_new_import(infopage)
    button_admin_to_new_import edit_admin_infopage_path(infopage.id_admin, pane: :picture_import)
  end


  def infopage_picture_admin_button_to_new_join_by_keyword(infopage)
    button_admin_to_new_join_by_keyword edit_admin_infopage_path(infopage.id_admin, pane: :picture_join_by_keyword)
  end


  def infopage_picture_admin_button_to_new_join_single(infopage)
    button_admin_to_new_join_single edit_admin_infopage_path(infopage.id_admin, pane: :picture_join_single)
  end


  def infopage_picture_admin_button_to_new_upload(infopage)
    button_admin_to_new_upload edit_admin_infopage_path(infopage.id_admin, pane: :picture_upload)
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
