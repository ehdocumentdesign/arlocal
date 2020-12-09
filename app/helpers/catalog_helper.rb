module CatalogHelper


  module_function


  def catalog_audio_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_audio)
  end

  def catalog_audio_filesystem_path(audio)
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_audio, audio.catalog_file_path)
  end


  def catalog_audio_url(audio)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_audio, audio.catalog_file_path), skip_pipeline: true
  end


  def catalog_icon_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_icons)
  end


  def catalog_icon_url(filename)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_icons, filename), skip_pipeline: true
  end


  def catalog_path_prefix_filesystem
    File.join(Rails.root, 'public', 'catalog')
  end


  def catalog_path_prefix_url
    '/catalog'
  end


  def catalog_path_suffix_audio
    'audio'
  end


  def catalog_path_suffix_icons
    'icons'
  end


  def catalog_path_suffix_pictures
    'pictures'
  end


  def catalog_picture_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_pictures)
  end


  def catalog_picture_filesystem_path(picture)
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_pictures, picture.catalog_file_path)
  end


  def catalog_picture_url(picture)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_pictures, picture.catalog_file_path), skip_pipeline: true
  end


end
