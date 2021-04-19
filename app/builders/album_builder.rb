class AlbumBuilder


  attr_reader :album


  def initialize
    @album = Album.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.album
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.create(album_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(album_params)
    end
  end



  public


  def assign_default_attributes
    @album.assign_attributes(params_default)
  end


  def assign_given_attributes(album_params)
    @album.assign_attributes(album_params)
  end


  private


  def params_default
    {
      artist: ArlocalSettings.first.artist_name,
      album_pictures_sorter_id: SorterAlbumPictures.find_by_symbol(:cover_manual_asc).id,
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      description_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      index_can_display_tracklist: true,
      index_tracklist_audio_includes_subtitles: true,
      indexed: true,
      involved_people_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      musicians_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      published: false,
      show_can_cycle_pictures: true,
    }
  end


end
