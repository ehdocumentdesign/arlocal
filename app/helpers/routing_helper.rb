module RoutingHelper


  def routing_controller(params)
    params[:controller].split('/').first
  end


  def routing_controller_is_admin(params)
    routing_controller(params) == 'admin'
  end


  def routing_controller_is_adminy(params)
    routing_controller_is_admin(params) || routing_controller_is_administrators(params)
  end


  def routing_controller_is_administrators(params)
    administrator_signed_in? && routing_controller(params) == 'administrators'
  end


  def routing_controller_is_administrators_sessions(params)
    params[:controller].include?('administrators/sessions')
  end


  def routing_controller_is_public(params)
    routing_controller(params) == 'public'
  end


  def routing_controller_is_publicy(params)
    (routing_controller(params) == 'public') || (routing_controller_is_administrators_sessions(params))
  end


  def routing_public_allowed_actions
    [ 'index', 'show' ]
  end


  def routing_public_allowed_controllers
    [ 'albums', 'audio', 'events', 'info', 'pictures', 'streams', 'videos' ]
  end


  def routing_role(params)
    if routing_controller_is_admin(params)
      :admin
    elsif routing_controller_is_public(params)
      :public
    end
  end


  def routing_role_opposite(params)
    case routing_role(params)
    when :admin
      :public
    when :public
      :admin
    end
  end


  def routing_through_a_public_path(params)
    action = params[:action]
    controller = params[:controller].split('/').last

    if routing_public_allowed_actions.include?(action) && routing_public_allowed_controllers.include?(controller)
      { action: action, controller: controller }
    else
      false
    end
  end


  def routing_will_allow_marquee(params)
    routing_as_public(params)
  end


  def routing_will_retain_edit_pane(arlocal_settings, pane)
    if (arlocal_settings) && (arlocal_settings.admin_forms_retain_pane_for_neighbors == true) && (pane)
      true
    else
      false
    end
  end


end
