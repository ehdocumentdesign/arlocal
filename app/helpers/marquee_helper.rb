module MarqueeHelper


  def marquee_will_display(arlocal_settings, params)
    routing_controller_is_public(params) && @arlocal_settings.marquee_will_render
  end


end
