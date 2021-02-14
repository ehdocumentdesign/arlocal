class PictureBuilder


  require 'exiftool'


  attr_reader :picture


  def initialize(args={})
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : nil
    picture = (Picture === args[:picture]) ? args[:picture] : Picture.new
    @arlocal_settings = arlocal_settings
    @metadata = nil
    @picture = picture
  end


  protected


  def self.build(args={})
    builder = new(args)
    yield(builder)
    builder.picture
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.collection_with_leading_nil(collection)
    [self.nil_picture].concat(collection.to_a)
  end


  def self.create(picture_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(picture_params)
    end
  end


  def self.create_from_import(params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(params)
      b.assign_source_type(params)
      b.assign_metadata
    end
  end


  def self.create_from_import_and_join_nested_album(params)
  end


  def self.create_from_import_and_join_nested_event(params)
  end


  def self.create_from_import_nested_within_album(album, params)
    picture_params = {
      source_catalog_file_path: params['pictures_attributes']['0']['source_catalog_file_path'],
      source_type: 'catalog'
    }
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(picture_params)
      b.assign_metadata
      b.join_to_album(album)
    end
  end


  def self.create_from_import_nested_within_event(event, params)
    picture_params = {
      source_catalog_file_path: params['pictures_attributes']['0']['source_catalog_file_path'],
      source_type: 'catalog'
    }
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(picture_params)
      b.assign_metadata
      b.join_to_event(event)
    end
  end


  def self.create_from_upload(params)
  end


  def self.create_from_upload_and_join_nested_album(params)
  end


  def self.create_from_upload_and_join_nested_event(params)
  end


  def self.create_from_upload_nested_within_album(album, params)
    picture_params = {
      image: params['pictures_attributes']['0']['image'],
      source_type: 'attachment'
    }
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(picture_params)
      b.assign_metadata
      b.join_to_album(album)
    end
  end


  def self.create_from_upload_nested_within_event(event, params)
    picture_params = {
      image: params['pictures_attributes']['0']['image'],
      source_type: 'attachment'
    }
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(picture_params)
      b.assign_metadata
      b.join_to_event(event)
    end
  end


  def self.nil_picture
    Picture.new(
      id: nil,
      title_without_markup: '(none)'
    )
  end



  public


  # TODO: these should be singleton methods?

  # TODO: these should be singleton methods?


  def assign_default_attributes
    @picture.assign_attributes(params_default)
  end


  def assign_given_attributes(picture_params)
    @picture.assign_attributes(picture_params)
  end


  def assign_metadata
    determine_metadata
    @picture.datetime_from_exif = determine_time_from_exif_formatting(@metadata.raw[:date_time_original])
    @picture.datetime_from_file = determine_time_from_exif_formatting(@metadata.raw[:file_modify_date])
  end


  def assign_source_type(params)
    if params.has_key?('recording')
      @picture.source_type = 'attachment'
    elsif params.has_key?('source_catalog_file_path')
      @picture.source_type = 'catalog'
    end
  end


  def join_to_album(album)
    album_id = album.id
    @picture.album_pictures.build(album_id: album_id)
  end


  def join_to_event(event)
    event_id = event.id
    @picture.event_pictures.build(event_id: event_id)
  end



  private


  def determine_metadata
    if determine_metadata_is_not_assigned
      case @picture.source_type
      when 'attachment'
        determine_metadata_from_attachment
      when 'catalog'
        determine_metadata_from_catalog
      end
    end
  end


  def determine_metadata_from_attachment
    if @picture.image.attached?
      @picture.image.open do |i|
        @metadata = Exiftool.new(i.path)
      end
    end
  end


  def determine_metadata_from_catalog
    if File.exists?(CatalogHelper.catalog_picture_filesystem_path(@picture))
      @metadata = Exiftool.new(CatalogHelper.catalog_picture_filesystem_path(@picture))
    end
  end


  def determine_metadata_is_assigned
    Exiftool === @metadata
  end


  def determine_metadata_is_not_assigned
    determine_metadata_is_assigned == false
  end


  def determine_time_from_exif_formatting(time_string_exif)
    if time_string_exif
      time_match_data = /(\d+):(\d+):(\d+)\s(\d+):(\d+):(\d+)(-?\d*:?\d*)/.match(time_string_exif)
      if time_match_data[7].to_s == ''
        time_array = time_match_data[1..6]
      else
        time_array = time_match_data[1..7]
      end
      Time.new(*time_array)
    end
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


end
