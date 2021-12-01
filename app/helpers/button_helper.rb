module ButtonHelper


  def button_admin_submit_to_destroy(path, data: nil)
    button_to 'Destroy', path, class: :arl_button_form_submit_destroy, data: data, method: :delete, title: 'destroy'
  end


  def button_admin_submit_to_purge_attachment(path, data: nil)
    button_to 'Purge Attachment', path, class: :arl_button_form_submit_destroy, data: data, method: :patch, title: 'destroy'
  end


  def button_admin_to_done_editing(path)
    tag.div(tag.a(icon_done_editing, href: path, class: :arl_button_admin_resource, method: :get, title: 'done editing'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_edit(path)
    tag.div(tag.a(icon_edit, href: path, class: :arl_button_admin_resource, method: :get, title: 'edit'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_edit_pane(current_pane: nil, target_link: nil, target_pane: nil)
    html_class = [:arl_active_link_container]
    if current_pane == target_pane
      html_class << :arl_admin_resource_edit_nav_item_current
    elsif current_pane != target_pane
      html_class << :arl_admin_resource_edit_nav_item
    end
    tag_anchor = tag.a(target_pane.to_s, class: :arl_admin_resource_edit_nav_item_link, href: target_link)
    tag.div tag_anchor, class: html_class, data: {tab: target_pane, url: target_link}
  end


  def button_admin_to_index(path)
    tag.div(tag.a(icon_index, href: path, class: :arl_button_admin_resource, method: :get, title: 'index'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_log_out
    button_to('log out', destroy_administrator_session_path, class: :arl_button_admin_console, form_class: :arl_admin_console_action, method: :delete)
  end


  def button_admin_to_new(path)
    tag.div(tag.a(icon_new, href: path, class: :arl_button_admin_resource, method: :get, title: 'new'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_new_import(path)
    tag.div(tag.a(icon_new_import, href: path, class: :arl_button_admin_resource, method: :get, title: 'import'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_new_join_by_keyword(path)
    tag.div(tag.a(icon_new_join_by_keyword, href: path, class: :arl_button_admin_resource, method: :get, title: 'join by keyword'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_new_join_single(path)
    tag.div(tag.a(icon_new_join_single, href: path, class: :arl_button_admin_resource, method: :get, title: 'join'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_new_upload(path)
    tag.div(tag.a(icon_new_upload, href: path, class: :arl_button_admin_resource, method: :get, title: 'upload'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_next(path)
    tag.div(tag.a(icon_next, href: path, class: :arl_button_admin_resource, method: :get, title: 'next'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_previous(path)
    tag.div(tag.a(icon_previous, href: path, class: :arl_button_admin_resource, method: :get, title: 'next'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_show(path)
    tag.div(tag.a(icon_show, href: path, class: :arl_button_admin_resource, method: :get, title: 'show'), class: :arl_button_admin_resource_spacing)
  end


  def button_admin_to_toggle_viewing_role(params)
    target_view = routing_role_opposite(params)
    target = routing_through_a_public_path(params)

    if target
      case target_view
      when :public
        button_action = target[:action]
        button_controller = '/public/' + target[:controller]
        button_label = 'to public view'
        button_link = url_for(action: button_action, controller: button_controller, id: params[:id])
      when :admin
        button_action = target[:action]
        button_controller = '/admin/' + target[:controller]
        button_label = 'to admin view'
        button_link = url_for(action: button_action, controller: button_controller, id: params[:id])
      end
      button_to(button_label, button_link, class: :arl_button_admin_console, form_class: :arl_admin_console_action, method: :get)
    end
  end


  def button_to_edit_profile(path)
    button_to icon_edit, path, class: :arl_button_admin_resource, method: :get, title: 'edit profile'
  end


  def button_to_next(path)
    link_to icon_next, path, class: :arl_button_nav_next
  end


  def button_to_previous(path)
    link_to icon_previous, path, class: :arl_button_nav_previous
  end


end
