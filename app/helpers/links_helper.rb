module LinksHelper


  require 'uri'


  def link_admin_button_to_done_editing(link)
    button_admin_to_done_editing admin_link_path(@link.id_admin)
  end


  def link_admin_button_to_edit(link)
    button_admin_to_edit edit_admin_link_path(link.id_admin)
  end


  def link_admin_button_to_edit_next(link, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_link_path(link.id_admin, pane: current_pane)
    else
      target_link = edit_admin_link_path(link.id_admin)
    end
    button_admin_to_next(target_link)
  end


  def link_admin_button_to_edit_previous(link, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_link_path(link.id_admin, pane: current_pane)
    else
      target_link = edit_admin_link_path(link.id_admin)
    end
    button_admin_to_previous(target_link)
  end


  def link_admin_button_to_index
    button_admin_to_index admin_links_path
  end


  def link_admin_button_to_new
    button_admin_to_new new_admin_link_path
  end


  def link_admin_button_to_next(link)
    button_admin_to_next admin_link_path(link.id_admin)
  end


  def link_admin_button_to_previous(link)
    button_admin_to_previous admin_link_path(link.id_admin)
  end


  def link_admin_edit_nav_button(link: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_link_path(link.id, pane: category),
      target_pane: category
    )
  end


  def link_parse(link, include_details: true)
    case link.address_type
    when :email
      link_parse_email(link, include_details: include_details)
    when :web
      link_parse_web(link, include_details: include_details)
    end
  end


  def link_parse_email(link, include_details: true)
    html_classes = [:arl_active_address_email, :arl_link_email]

    result_heading = tag.dh(link.name, class: :arl_link_heading)

    result_link = tag.a(link.effective_inline_text, class: html_classes, data: link.address_href_hashed )
    result_address = tag.address(result_link, class: :arl_link_address)
    result_description = tag.dd(result_address, class: :arl_link_description)

    result = tag.div(result_heading + result_description, class: :arl_link)
    result
  end


  def link_parse_web(link, include_details: true)
    # uri = [:scheme, :userinfo, :host, :port, :registry, :path, :opaque, :query, :fragment]
    uri_scheme = URI.split(link.address_href)[0]
    if uri_scheme == nil
      address_href = 'http://' + link.address_href
    else
      address_href = link.address_href
    end

    result_heading = tag.dh(link.name, class: :arl_link_heading)

    result_link = link_to(link.effective_inline_text, address_href, class: :arl_link_url)
    result_address = tag.address(result_link, class: :arl_link_address)
    result_description = tag.dd(result_address, class: :arl_link_description)

    if include_details
      result_details = tag.div(parser_div(link.details_props), class: :arl_link_details)
      result_description.concat tag.dd(result_details, class: :arl_link_description)
    end

    result = tag.div(result_heading + result_description, class: :arl_link)
    result
  end



  def link_reference_admin_link(link)
    link_to(link.title, admin_link_path(link.id_admin), class: :arl_link_url)
  end



  def link_to_admin_about_arlocal_markup_types(text)
    link_to text, admin_about_arlocal_markup_types_path, target: '_blank'
  end


end
