module EventsHelper


  def event_admin_button_to_done_editing(event)
    button_admin_to_done_editing admin_event_path(@event.id_admin)
  end


  def event_admin_button_to_edit(event)
    button_admin_to_edit edit_admin_event_path(event.id_admin)
  end


  def event_admin_button_to_edit_next(event, arlocal_settings: nil, target_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, target_pane)
      target_link = edit_admin_event_path(event.id_admin, pane: target_pane)
    else
      target_link = edit_admin_event_path(event.id_admin)
    end
    button_admin_to_next(target_link)
  end


  def event_admin_button_to_edit_previous(event, arlocal_settings: nil, target_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, target_pane)
      target_link = edit_admin_event_path(event.id_admin, pane: target_pane)
    else
      target_link = edit_admin_event_path(event.id_admin)
    end
    button_admin_to_previous(target_link)
  end


  def event_admin_button_to_index
    button_admin_to_index admin_events_path
  end


  def event_admin_button_to_new
    button_admin_to_new new_admin_event_path
  end


  def event_admin_button_to_next(event)
    button_admin_to_next admin_event_path(event.id_admin)
  end


  def event_admin_button_to_previous(event)
    button_admin_to_previous admin_event_path(event.id_admin)
  end


  def event_admin_edit_nav_button(event: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_event_path(event.id_admin, pane: category),
      target_pane: category
    )
  end


  def event_linkable_city(event)
    if event.does_have_map_url
      event_linked_city(event)
    else
      event_linkless_city(event)
    end
  end


  def event_linked_city(event)
    link_to event.city, event.map_url, class: :arl_link_url, target: '_blank'
  end


  def event_linkless_city(event)
    event.city
  end


  def event_linkable_venue(event)
    if event.does_have_venue_url
      event_linked_venue(event)
    else
      event_linkless_venue(event)
    end
  end


  def event_linked_venue(event)
    link_to event.venue, event.venue_url, class: :arl_link_url, target: '_blank'
  end


  def event_linkless_venue(event)
    event.venue
  end


  def event_public_filter_select
    select(
      :events_index,
      :filter,
      SorterIndexPublicEvents.options_for_select(:url),
      { include_blank: false, selected: SorterIndexPublicEvents.find_id_from_param(params[:filter]) },
      { class: [:arl_active_refine_selection, :arl_button_select, :arl_events_index_filter]}
    )
  end


  def event_reference_admin_link(event)
    link_to(event.date_and_venue, admin_event_path(event.id_admin), class: :arl_link_url)
  end



  def event_script_jPlayer_playlist(event)
    playlist_json = Array.new
    event.event_audio.each do |ea|
      playlist_json << js_fragment_jp_audio_ordered(ea)
    end
    js = ''
    js << js_function_jp_playlist_onready(playlist_json)
    app_script_element_for(js)
  end


  def event_statement_audio_count(event)
    pluralize event.audio_count.to_i, 'audio'
  end


  def event_statement_keywords_count(event)
    pluralize event.keywords_count.to_i, 'keyword'
  end


  def event_statement_pictures_count(event)
    pluralize event.pictures_count.to_i, 'picture'
  end


end
