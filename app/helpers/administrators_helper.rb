module AdministratorsHelper


  def administrator_registration_edit_nav_button(category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_administrator_registration_path(pane: category),
      target_pane: category
    )
  end


end
