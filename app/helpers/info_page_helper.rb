module InfoPageHelper
  
  
  def info_admin_edit_nav_button(info_page: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane, 
      target_link: edit_admin_info_path(info_page.id, pane: category), 
      target_pane: category
    )
  end
  
  
  def info_page_links_count_statement(info_page)
    pluralize info_page.links.count.to_i, 'link'
  end

  
end