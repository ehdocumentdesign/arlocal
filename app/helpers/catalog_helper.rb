module CatalogHelper


  module_function


  def catalog_audio_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_audio)
  end

  def catalog_audio_filesystem_path(audio)
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_audio, audio.source_catalog_file_path)
  end


  def catalog_audio_url(audio)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_audio, audio.source_catalog_file_path), skip_pipeline: true
  end


  def catalog_icon_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_icons)
  end


  def catalog_icon_url(filename)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_icons, filename), skip_pipeline: true
  end


  def catalog_path_prefix_filesystem
    Rails.application.config.x.arlocal[:artist_catalog_filesystem_dirname]
  end


  def catalog_path_prefix_url
    Rails.application.config.x.arlocal[:artist_catalog_url_path_prefix]
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


  def catalog_path_suffix_videos
    'videos'
  end


  def catalog_picture_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_pictures)
  end


  def catalog_picture_filesystem_path(picture)
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_pictures, picture.source_catalog_file_path)
  end


  def catalog_picture_url(picture)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_pictures, picture.source_catalog_file_path), skip_pipeline: true
  end


  def catalog_video_filesystem_dirname
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_videos)
  end

  def catalog_video_filesystem_path(video)
    File.join(catalog_path_prefix_filesystem, catalog_path_suffix_videos, video.source_catalog_file_path)
  end


  def catalog_video_url(video)
    asset_url File.join(catalog_path_prefix_url, catalog_path_suffix_videos, video.source_catalog_file_path), skip_pipeline: true
  end


end
