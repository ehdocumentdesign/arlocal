class PictureBuilder


  def collection_with_leading_nil(collection)
    [nil_picture].concat(collection.to_a)
  end


  def default
    Picture.new(params_default)
  end


  def default_with(params_given)
    params = params_default.merge(params_given)
    Picture.new(params)
  end


  def nil_picture
    Picture.new(
      id: nil,
      title_without_markup: '(none)'
    )
  end


  def params_default
    {
      credits_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      credits_text_markup: '',
      description_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      description_text_markup: '',
      indexed: true,
      published: false,
      show_can_display_title: true,
      source_catalog_file_path: '',
      title_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      title_text_markup: ''
    }
  end


  def prepare_from_import(params_given)
    picture = PictureExifBuilder.new(default_with(params_given)).prepare_from_import
    picture.title_text_markup = "#{picture.catalog_basename} #{picture.datetime.to_s}"
    picture
  end


  def prepare_from_upload(params_given)
    picture = PictureExifBuilder.new(default_with(params_given)).prepare_from_upload
    picture.title_text_markup = "#{picture.image_file_name} #{picture.datetime.to_s}"
    picture
  end


  def refresh_exif(picture)
    picture = PictureExifBuilder.new(picture).refresh
    picture
  end

end
