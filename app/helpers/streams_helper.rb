module StreamsHelper


  def stream_admin_button_to_done_editing(stream)
    button_admin_to_done_editing admin_stream_path(stream.id_admin)
  end


  def stream_admin_button_to_edit(stream)
    button_admin_to_edit edit_admin_stream_path(stream.id_admin)
  end


  def stream_admin_button_to_edit_next(stream, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_stream = edit_admin_stream_path(stream.id_admin, pane: current_pane)
    else
      target_stream = edit_admin_stream_path(stream.id_admin)
    end
    button_admin_to_next(target_stream)
  end


  def stream_admin_button_to_edit_previous(stream, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_stream = edit_admin_stream_path(stream.id_admin, pane: current_pane)
    else
      target_stream = edit_admin_stream_path(stream.id_admin)
    end
    button_admin_to_previous(target_stream)
  end


  def stream_admin_button_to_index
    button_admin_to_index admin_streams_path
  end


  def stream_admin_button_to_new
    button_admin_to_new new_admin_stream_path
  end


  def stream_admin_button_to_next(stream)
    button_admin_to_next edit_admin_stream_path(stream.id_admin)
  end


  def stream_admin_button_to_previous(stream)
    button_admin_to_previous edit_admin_stream_path(stream.id_admin)
  end


  def stream_admin_edit_nav_button(stream: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_stream_path(stream.id_admin, pane: category),
      target_pane: category
    )
  end


end
