module RoleHelper


  def role_is_administrator(params)
    (routing_controller_is_admin(params)) ||
    (administrator_signed_in?)
  end


  def role_is_administrator_signing_in(params)
    routing_controller_is_administrators_sessions(params)
  end


  def role_is_public(params)
    (administrator_signed_in? == false) || (routing_controller_is_public(params))
  end


  def role(params)
    if role_is_administrator(params)
      :administrator
    elsif role_is_public(params)
      :public
    else
      :undetermined
    end
  end


  def role_opposite(params)
    case role(params)
    when :administrator
      :public
    when :public
      :admin
    when :undetermined
      :undetermined
    end
  end


end
