class Video


  # add this last.
  # has_one_attached :recording


  def description_props
    { parser_id: 4, text_markup: 'Description'}
  end


  def title
    'Silverton'
  end


  def slug
    'silverton'
  end


  def source_attachment_file_path
  end


  def source_catalog_file_path
    'yourallgay.mkv'
  end


  def source_embed_url
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


  def source_type
    # :attachment
    # :catalog
    # :embed

    :catalog
  end


end
