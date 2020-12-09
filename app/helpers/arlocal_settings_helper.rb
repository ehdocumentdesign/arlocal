module ArlocalSettingsHelper
  
  
  def arlocal_settings_admin_edit_nav_button(arlocal_settings: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_arlocal_settings_path(arlocal_settings, pane: category),
      target_pane: category
    )
  end
  
  
end