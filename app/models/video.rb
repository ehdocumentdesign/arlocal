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


  def source_attachment_path
  end


  def source_catalog_path
  end


  def source_embed_url
  end


  def source_type
    # :attachment
    # :catalog
    # :embed
  end


end
