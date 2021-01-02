class AudioBuilder


  require 'mediainfo'


  attr_reader :audio


  def self.build(args={})
    builder = new(args)
    yield(builder)
    builder.audio
  end


  def initialize(args={})
    @arlocal_settings = args[:arlocal_settings]
    @audio = Audio.new
    @mediainfo = nil
  end


  public


  def assign_default_attributes
    @audio.assign_attributes(params_default)
  end


  def assign_given_attributes(audio_params)
    @audio.assign_attributes(audio_params)
  end


  def find_preexisting(id)
    @audio = Audio.find(id)
  end


  def read_metadata
    determine_mediainfo
    @audio.audio_artist = "#{@mediainfo.general.performer}"
    @audio.copyright_text_markup = "© #{@mediainfo.general.recorded_date}"
    @audio.title = "#{@mediainfo.general.track}"
    @audio.duration_mins = @mediainfo.general.duration.divmod(1000)[0].divmod(60)[0]
    @audio.duration_secs = @mediainfo.general.duration.divmod(1000)[0].divmod(60)[1]
    @audio.duration_mils = @mediainfo.general.duration.divmod(1000)[1]
  end


  def set_new_album_order
    determine_mediainfo
    @audio.album_audio.first.album_order = @mediainfo.general.track_position
  end


  def set_new_event_order
    determine_mediainfo
    @audio.event_audio.first.event_order = @mediainfo.general.track_position
  end


  def update_joined_albums_order
    determine_mediainfo
    if @audio.does_have_albums
      album = Album.find_by_title(@mediainfo.general.album)
      if album
        @audio.album_audio.where(album_id: album.id).each do |aa|
          aa.album_order = @mediainfo.general.track_position
          aa.save
        end
      end
    end
  end


  def update_joined_events_order
    if @audio.does_have_events
      event = Event.find_by_title(@mediainfo.general.album)
      if event
        @audio.event_audio.where(event_id: event.id).each do |ea|
          ea.event_order = @mediainfo.general.track_position
          ea.save
        end
      end
    end
  end


  def update_joined_resources_order
    update_joined_albums_order
    update_joined_events_order
  end



  private


  def determine_mediainfo
    if mediainfo_is_not_assigned
      case @audio.source_type.to_sym
      when :attachment
        determine_mediainfo_from_attachment
      when :catalog
        determine_mediainfo_from_catalog
      end
    end
  end


  def determine_mediainfo_from_attachment
    if @audio.recording != nil
      @mediainfo = MediaInfo.from(@audio.recording.blob)
    end
  end


  def determine_mediainfo_from_catalog
    if File.exists?(CatalogHelper.catalog_audio_filesystem_path(@audio))
      @mediainfo = MediaInfo.from(CatalogHelper.catalog_audio_filesystem_path(@audio))
    end
  end


  def mediainfo_is_assigned
    MediaInfo::Tracks === @mediainfo
  end


  def mediainfo_is_not_assigned
    mediainfo_is_assigned == false
  end


  def params_default
    {
      artist: params_default_artist,
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      date_released: params_default_date_released,
      description_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      indexed: true,
      involved_people_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      isrc_country_code: params_default_isrc_country_code,
      isrc_registrant_code: params_default_isrc_registrant_code,
      musicians_parser_id: MarkupParser.find_by_symbol(:no_formatting).id
    }
  end


  def params_default_artist
    if @arlocal_settings
      @arlocal_settings.artist_name
    end
  end


  def params_default_date_released
    if params_default_date_released_enabled
      @arlocal_settings.audio_default_date_released
    else
      nil
    end
  end


  def params_default_date_released_enabled
    @arlocal_settings && @arlocal_settings.audio_default_date_released_enabled
  end


  def params_default_isrc_country_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_country_code
    end
  end


  def params_default_isrc_registrant_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_registrant_code
    end
  end


end



# def prepare_from_import(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).import
#   audio
# end
#
#
# def prepare_from_import_for_album(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).import_to_album
#   audio
# end
#
#
# def prepare_from_import_for_event(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).import_to_event
#   audio
# end
#
#
# def prepare_from_upload(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).upload
#   audio
# end
#
#
# def prepare_from_upload_for_album(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).upload_to_album
#   audio
# end
#
#
# def prepare_from_upload_for_event(params_given)
#   audio = AudioId3Builder.new(default_with(params_given)).upload_to_event
#   audio
# end
#
#
# def refresh_id3(audio)
#   AudioId3Builder.new(audio).refresh
# end
