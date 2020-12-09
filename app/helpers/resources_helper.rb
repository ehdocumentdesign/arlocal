module ResourcesHelper

  # TODO: Reconcile this method with PicturesHelper::picture_preferred_url() and _show_album_picture_img.haml
  # def resource_coverpicture_tag(resource, html_class: nil)
  #   if resource.does_have_coverpicture
  #     catalog_picture_tag(resource.coverpicture_picture, html_class: html_class)
  #   else
  #     image_tag('', class: html_class)
  #   end
  # end


  def resource_coverpicture_tag(resource, html_class: nil)
    if resource.does_have_coverpicture
      picture_preferred_tag(resource.coverpicture_picture, html_class: html_class)
    else
      image_tag('', class: html_class)
    end
  end


  def resource_joined_albums_count_statement(resource)
    pluralize resource.albums_count.to_i, 'album'
  end


  def resource_joined_audio_count_statement(resource)
    pluralize resource.audio_count.to_i, 'audio'
  end


  def resource_joined_events_count_statement(resource)
    pluralize resource.events_count.to_i, 'event'
  end


  def resource_joined_links_count_statement(resource)
    pluralize resource.links_count.to_i, 'link'
  end


  def resource_joined_pictures_count_statement(resource)
    pluralize resource.pictures_count.to_i, 'picture'
  end


  def resource_joined_keywords_count_statement(resource)
    pluralize resource.keywords_count.to_i, 'keyword'
  end


  # generates functionality in resource#show to cycle through all resource_pictures by click/tap on image element
  def resource_script_picture_cycler(resource, view: :published)
    picture_filepaths = Array.new
    case view
    when :all
      picture_filepaths << resource.pictures_all_sorted.map { |picture| picture_preferred_url(picture) }
    when :published
      picture_filepaths << resource.pictures_published_sorted.map { |picture| picture_preferred_url(picture) }
    end
    filepath_string = picture_filepaths.flatten.map {|path| '"' + path + '"'}.join(',')
    app_script_element_for(js_function_album_picture_cycler(filepath_string))
  end

  #
  # NOTE: Legacy Code
  #
  # returns a matching path for selectors created in controllers, used in views that render 'shared/selector_list'
  # 'type' is key in @selectors hash and matches class of objects used as selectors
  # returns a routeable link for resource#index_by_[xxx]
  # def resource_selector_link_to(current_controller_path, selector_type_from_hash_key, html_class: nil, selector: nil)
  #   action = 'index'
  #   id_key = nil
  #   link_path = String.new
  #   if selector
  #     if (selector.class.to_s.downcase == 'Keyword') && (selector.can_select?(resource_type: controller_name) == false)
  #       html_class = 'admin'
  #     end
  #     title = selector.title
  #     case selector_type_from_hash_key
  #     when :albums
  #       action = 'index_by_album'
  #       id_key = 'album_id'
  #     when :keywords
  #       action = 'index_by_keyword'
  #       id_key = 'keyword_id'
  #     end
  #   else
  #     title = "(no #{selector_type_from_hash_key.to_s.downcase})"
  #     case selector_type_from_hash_key
  #     when :albums
  #       action = 'index_no_albums'
  #     when :keywords
  #       action = 'index_no_keywords'
  #     end
  #   end
  #   link_path = { controller: current_controller_path, action: action }
  #   if id_key
  #     link_path.merge!( { id_key.to_sym => selector.id_public } )
  #   end
  #   link_to title, link_path, class: html_class
  # end


  def resource_slug_form_explanation(resource)
    sanitize("Leave blank to generate from <b>#{resource.slug_source.to_s.humanize(capitalize: false)}</b>.", tags: ['b'])
  end



  private


  def app_script_element_for(js)
    case Rails.env
    when 'production'
      assembled_script = String.new
      js.each_line { |l| assembled_script << l.strip }
    when 'development'
      assembled_script = js
    else
      assembled_script = js
    end
    tag.script(sanitize(assembled_script))
  end


end
