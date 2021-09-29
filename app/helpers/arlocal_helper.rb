module ArlocalHelper


  ### _header_admin
  ###  used when an administrator is logged on


  def arlocal_admin_artist_home_link(arlocal_settings)
    link_to @arlocal_settings.artist_name_downcase, admin_root_path, class: :arl_header_artist_name
  end


  def arlocal_admin_nav_link(category)
    html_class = :arl_header_nav_category_admin
    case category
    when :administrators
      arlocal_admin_nav_link_administrators(html_class)
    when :albums
      arlocal_admin_nav_link_albums(html_class)
    when :arlocal_settings
      arlocal_admin_nav_link_arlocal_settings(html_class)
    when :articles
      arlocal_admin_nav_link_articles(html_class)
    when :audio
      arlocal_admin_nav_link_audio(html_class)
    when :events
      arlocal_admin_nav_link_events(html_class)
    when :info
      arlocal_admin_nav_link_info(html_class)
    when :keywords
      arlocal_admin_nav_link_keywords(html_class)
    when :links
      arlocal_admin_nav_link_links(html_class)
    when :pictures
      arlocal_admin_nav_link_pictures(html_class)
    when :stream
      arlocal_admin_nav_link_stream(html_class)
    when :videos
      arlocal_admin_nav_link_videos(html_class)
    end
  end


  def arlocal_admin_nav_link_administrators(html_class)
    link_to 'administrators', admin_administrators_path, class: html_class
  end


  def arlocal_admin_nav_link_albums(html_class)
    link_to 'albums', admin_albums_path, class: html_class
  end


  def arlocal_admin_nav_link_arlocal_settings(html_class)
    link_to 'A&R.local', edit_admin_arlocal_settings_path, class: html_class
  end


  def arlocal_admin_nav_link_articles(html_class)
    link_to 'articles', admin_articles_path, class: html_class
  end


  def arlocal_admin_nav_link_audio(html_class)
    link_to 'audio', admin_audio_index_path, class: html_class
  end


  def arlocal_admin_nav_link_events(html_class)
    link_to 'events', admin_events_path, class: html_class
  end


  def arlocal_admin_nav_link_info(html_class)
    link_to 'info', admin_infopages_path, class: html_class
  end


  def arlocal_admin_nav_link_keywords(html_class)
    link_to 'keywords', admin_keywords_path, class: html_class
  end


  def arlocal_admin_nav_link_links(html_class)
    link_to 'links', admin_links_path, class: html_class
  end


  def arlocal_admin_nav_link_pictures(html_class)
    link_to 'pictures', admin_pictures_path, class: html_class
  end


  def arlocal_admin_nav_link_stream(html_class)
    link_to 'stream', admin_streams_path, class: html_class
  end


  def arlocal_admin_nav_link_videos(html_class)
    link_to 'videos', admin_videos_path, class: html_class
  end



  ### _header_public
  ### used for all public visitors


  def arlocal_public_artist_home_link(arlocal_settings)
    link_to @arlocal_settings.artist_name_downcase, root_path, class: :arl_header_artist_name
  end


  def arlocal_public_nav_link(arlocal_settings, category)
    html_class = :arl_header_nav_category
    case category
    when :albums
      arlocal_public_nav_link_albums(arlocal_settings, html_class)
    when :audio
      arlocal_public_nav_link_audio(arlocal_settings, html_class)
    when :events
      arlocal_public_nav_link_events(arlocal_settings, html_class)
    when :info
      arlocal_public_nav_link_info(arlocal_settings, html_class)
    when :pictures
      arlocal_public_nav_link_pictures(arlocal_settings, html_class)
    when :stream
      arlocal_public_nav_link_stream(arlocal_settings, html_class)
    when :videos
      arlocal_public_nav_link_videos(arlocal_settings, html_class)
    end
  end


  def arlocal_public_nav_link_albums(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_albums
      link_to 'albums', public_albums_path, class: html_class
    end
  end


  def arlocal_public_nav_link_audio(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_audio
      link_to 'audio', public_audio_path, class: html_class
    end
  end


  def arlocal_public_nav_link_events(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_events
      link_to 'events', public_events_path, class: html_class
    end
  end


  def arlocal_public_nav_link_info(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_info
      link_to 'info', public_infopage_first_path, class: html_class
    end
  end


  def arlocal_public_nav_link_pictures(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_pictures
      link_to 'pictures', public_pictures_path, class: html_class
    end
  end


  def arlocal_public_nav_link_stream(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_stream
      link_to 'stream', public_streams_path, class: html_class
    end
  end


  def arlocal_public_nav_link_videos(arlocal_settings, html_class)
    if @arlocal_settings.public_nav_can_include_videos
      link_to 'videos', public_videos_path, class: html_class
    end
  end



  ### module: administrators
  ### arlocal_settings form helpers



  def arlocal_settings_admin_edit_nav_button(arlocal_settings: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_arlocal_settings_path(arlocal_settings, pane: category),
      target_pane: category
    )
  end


end
