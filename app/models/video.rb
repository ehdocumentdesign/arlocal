class Video


  # add these last.
  #
  # has_one_coverpicture
  # has_one_attached :recording


  def description_props
    { parser_id: 4, text_markup: 'Description'}
  end


  def slug
    'silverton'
  end


  def source_attachment_file_path
  end


  def source_catalog_file_path
    'yourallgay.mp4'
  end


  def source_dimension_height
    880
  end


  def source_dimension_width
    956
  end


  def source_file_extname
    File::extname(source_file_path.to_s)
  end


  def source_file_extension
    source_file_extname.to_s.gsub(/\A./,'')
  end


  def source_file_mime_type
    Mime::Type.lookup_by_extension(source_file_extension)
  end


  def source_file_path
    case source_type
    when :attachment
      source_attachment_file_path
    when :catalog
      source_catalog_file_path
    end
  end


  def source_is_file
    case source_type
    when :attachment
      true
    when :catalog
      true
    else
      false
    end
  end


  def source_is_url
    case source_type
    when :url
      true
    else
      false
    end
  end


  def source_type
    # :attachment
    # :catalog
    # :url
    :catalog
  end


  def source_url
    'https://www.youtube.com/embed/rmuPs0uCe3w'
  end


  def thumbnail
  end


  def title
    'Silverton'
  end


end
