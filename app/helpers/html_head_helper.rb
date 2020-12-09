module HtmlHeadHelper
  

  def html_head_favicon_tags(arlocal_settings)
    result = ''
    if controller_is_public
      filename = arlocal_settings.html_head_favicon_catalog_filepath.to_s
      if filename != ''
        result << favicon_link_tag(catalog_icon_url(filename), rel: 'icon')
        result << favicon_link_tag(catalog_icon_url(filename), rel: 'apple-touch-icon')
      end
    elsif controller_is_adminy
      filename = url_for('/arlocal/arlocal-logo-icon.png')
      result << favicon_link_tag(filename, rel: 'icon')
      result << favicon_link_tag(filename, rel: 'apple-touch-icon')
    end
    result.html_safe
  end
  
  
  def html_head_javascripts
    result = ''
    result << javascript_include_tag('application')
    if administrator_signed_in?
      result << javascript_include_tag('admin')
    end
    result.html_safe
  end


  def html_head_meta_charset_tag
    '<meta charset="utf-8">'.html_safe
  end
  
  
  def html_head_meta_description(text)
    tag.meta(name: 'description', content: sanitize(text)).html_safe
  end
  
  
  def html_head_meta_viewport_tags
    '<meta name="viewport" content="initial-scale=1.0" />'.html_safe
  end
    
  
  def html_head_stylesheets
    stylesheet_link_tag('application')
  end
  
  
  def html_head_title(arlocal_settings, html_head_title_subtitle)
    title_string = "#{arlocal_settings.artist_name} #{html_head_title_subtitle}"
    result = tag.title(sanitize(title_string)).html_safe
    result.html_safe
  end
  
  
  # extends the HTML title appearing in browser title or tab
  def html_head_title_extend!(*subtitle_array)
    content_for :html_head_title_subtitle, (' / ' + subtitle_array.join(' / '))
  end
    

  
  private
  
  
  def controller_action_renders_jplayer
    resource = controller_path.split('/')[0]
    if (resource == 'albums') && (action_name == 'show')
      true
    end
  end
    
    
  def controller_is_adminy
    if (controller_name == 'sessions') || (controller_path.split('/')[0] == 'admin')
      true
    end
  end
    

  def controller_is_public
    if (['admin','devise','session'].include?(controller_path.split('/')[0])) == false
      true
    end
  end
  
  
  def html_head_will_include_google_analytics(arlocal_settings)
    if (administrator_signed_in? == false) && (controller_is_public) && (arlocal_settings.html_head_public_should_include_google_analytics)
      true
    end
  end
  
  
end
