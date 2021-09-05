module CatalogHelper


  def catalog_dirname(trailing_separator: false)
    case trailing_separator
    when true
      "#{catalog_path_prefix_filesystem}#{File::SEPARATOR}"
    else
      "#{catalog_path_prefix_filesystem}"
    end
  end


  def catalog_file_exists?(item)
    File.exists?(catalog_filesystem_path(item))
  end


  def catalog_file_path(item)
    case item
    when Audio, Picture, Video
      File.join(catalog_path_prefix_filesystem, item.source_catalog_file_path)
    when String
      File.join(catalog_path_prefix_filesystem, item)
    end
  end


  def catalog_path_prefix_filesystem
    Rails.application.config.x.arlocal[:artist_catalog_filesystem_dirname]
  end


  def catalog_path_prefix_url
    Rails.application.config.x.arlocal[:artist_catalog_url_path_prefix]
  end


  def catalog_url(item)
    case item
    when Audio, Picture, Video
      asset_url File.join(catalog_path_prefix_url, item.source_catalog_file_path), skip_pipeline: true
    when String
      asset_url File.join(catalog_path_prefix_url, item), skip_pipeline: true
    end
  end


end
