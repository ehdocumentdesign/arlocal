module PicturesHelper


  def picture_admin_button_to_done_editing(picture)
    button_admin_to_done_editing admin_picture_path(@picture.id_admin)
  end


  def picture_admin_button_to_edit(picture)
    button_admin_to_edit edit_admin_picture_path(picture.id_admin)
  end


  def picture_admin_button_to_edit_next(picture, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_picture_path(picture.id_admin, pane: current_pane)
    else
      target_link = edit_admin_picture_path(picture.id_admin)
    end
    button_admin_to_next(target_link)
  end


  def picture_admin_button_to_edit_previous(picture, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_picture_path(picture.id_admin, pane: current_pane)
    else
      target_link = edit_admin_picture_path(picture.id_admin)
    end
    button_admin_to_previous(target_link)
  end


  def picture_admin_button_to_index
    button_admin_to_index admin_pictures_path
  end


  def picture_admin_button_to_new
    button_admin_to_new new_admin_picture_path
  end


  def picture_admin_button_to_new_import
    button_admin_to_new_import admin_picture_new_import_menu_path
  end


  def picture_admin_button_to_new_upload
    button_admin_to_new_upload admin_picture_new_upload_menu_path
  end


  def picture_admin_button_to_next(picture)
    button_admin_to_next admin_picture_path(picture.id_admin)
  end


  def picture_admin_button_to_previous(picture)
    button_admin_to_previous admin_picture_path(picture.id_admin)
  end


  def picture_admin_edit_nav_button(picture: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_picture_path(picture.id_admin, pane: category),
      target_pane: category
    )
  end


  def picture_admin_filter_select(form, selected: nil)
    form.select(
      :admin_index_audio_sorter_id,
      SorterIndexAdminPictures.options_for_select(:url),
      { include_blank: false, selected: selected },
      { class: [:arl_active_refine_selection, :arl_button_select, :arl_audio_index_filter] }
    )
  end


  def picture_album_admin_button_to_new_join_single(picture)
    button_admin_to_new_join_single edit_admin_picture_path(picture.id_admin, pane: :album_join_single)
  end


  def picture_datetime_cascade_value_statement(picture)
    picture_datetime = tag.span("#{picture.datetime_effective_value}")
    sanitize("#{picture_datetime}")
  end



  def picture_file_path_div_with_indicators(picture, html_class: [])
    filename = picture.source_file_path
    html_class = [html_class].flatten
    case picture.source_type
    when 'attachment'
      path_to_file = ActiveStorage::Blob.service.send(:path_for, picture.source_attachment.key)
      if File.exist?(path_to_file) == false
        html_class << :arl_error_file_missing
      end
    when 'catalog'
      path_to_file = catalog_file_path(picture)
      if File.exists?(path_to_file) == false
        html_class << :arl_error_file_missing
      end
    end
    tag.div filename, class: html_class
  end


  def picture_options_for_select(picture_options, form)
    options_for_select(
      picture_options.map { |picture| [
          picture.title_without_markup,
          picture.id,
          {'data-picture-src' => picture_preferred_url(picture)}
      ] },
      selected_key = form.object.picture_id
    )
  end


  def picture_preferred_tag(picture, html_class: nil)
    case picture
    when nil
      tag.img(class: html_class, src: Rails.application.config.x.arlocal[:app_nilpicture_file_path], skip_pipeline: true)
    when Picture
      tag.img(src: picture_preferred_url(picture), class: html_class)
    end
  end


  def picture_preferred_url(picture)
    case picture.source_type
    when 'attachment'
      if picture.source_attachment.attached?
        url_for(picture.source_attachment)
      end
    when 'catalog'
      catalog_url(picture)
    when nil
      url_for(Rails.application.config.x.arlocal[:app_nilpicture_file_path])
    end
  end


  def picture_reference_admin_link(picture)
    link_to(picture.title, admin_picture_path(picture.id_admin), class: :arl_link_url)
  end



  def picture_statement_albums_count(picture)
    pluralize picture.albums_count.to_i, 'album'
  end


  def picture_statement_events_count(picture)
    pluralize picture.events_count.to_i, 'event'
  end


  def picture_statement_keywords_count(picture)
    pluralize picture.keywords_count.to_i, 'keyword'
  end


  def picture_thumbnail_link(picture, html_class: :arl_picture_thumbnail)
    link_to(picture_preferred_tag(picture, html_class: html_class), public_picture_path(picture.id_public))
  end


  def picture_title_link(picture, path, html_class: nil)
    link_to parser_div(picture.title_props), path, class: html_class
  end


end
