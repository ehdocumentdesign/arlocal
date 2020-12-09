class AudioId3Builder


  #TODO: Error handling if audio file path is invalid


  require 'taglib'


  def initialize(audio)
    @action = nil
    @audio = audio
    @audio_props = nil
    @audio_tag = nil
  end


  public


  def import
    @action = :create
    if File.exists?(audio_catalog_path)
      audio_taglib_read(audio_catalog_path)
    end
    return @audio
  end


  def import_to_album
    @action = :create_on_album
    if File.exists?(audio_catalog_path)
      audio_taglib_read(audio_catalog_path)
    end
    return @audio
  end


  def import_to_event
    @action = :create_on_event
    if File.exists?(audio_catalog_path)
      audio_taglib_read(audio_catalog_path)
    end
    return @audio
  end


  def upload
    @action = :create
    @audio.recording.open do |blob|
      audio_taglib_read(blob.path)
    end
    return @audio
  end


  def upload_to_album
    @action = :create_on_album
    @audio.recording.open do |blob|
      audio_taglib_read(blob.path)
    end
    return @audio
  end


  def upload_to_event
    @action = :create_on_event
    @audio.recording.open do |blob|
      audio_taglib_read(blob.path)
    end
    return @audio
  end


  def refresh
    @action = :update
    case @audio.file_source_type
    when :attachment
      @audio.recording.open do |blob|
        audio_taglib_read(blob.path)
      end
    when :catalog
      if File.exists?(audio_catalog_path)
        audio_taglib_read(audio_catalog_path)
      end
    end
    return @audio
  end



  private


  def audio_catalog_path
    File.absolute_path(CatalogHelper.catalog_audio_filesystem_path(@audio))
  end


  def audio_taglib_read(path)
    case @audio.file_type
    when 'm4a'
      audio_taglib_read_m4a(path)
    end
  end


  def audio_taglib_read_m4a(path)
    TagLib::MP4::File.open(path) do |m4a|
      @audio_props = m4a.audio_properties
      @audio_tag = m4a.tag
      set_basics
      set_conditionals
    end
  end


  def set_basics
    @audio.artist = "#{@audio_tag.artist}"
    @audio.copyright_text_markup = "© #{@audio_tag.year}"
    @audio.title = "#{@audio_tag.title}"
    @audio.duration_mins = @audio_props.length_in_milliseconds.divmod(1000)[0].divmod(60)[0]
    @audio.duration_secs = @audio_props.length_in_milliseconds.divmod(1000)[0].divmod(60)[1]
    @audio.duration_mils = @audio_props.length_in_milliseconds.divmod(1000)[1]
  end


  def set_conditionals
    case @action
    when :create_on_album
      set_conditionals_create_album_order
    when :create_on_event
      set_conditionals_create_event_order
    when :update
      set_conditionals_update_album_order
      set_conditionals_update_event_order
    end
  end


  def set_conditionals_create_album_order
    @audio.album_audio.first.album_order = @audio_tag.track
  end


  def set_conditionals_create_event_order
    @audio.event_audio.first.event_order = @audio_tag.track
  end


  def set_conditionals_update_album_order
    if @audio.does_have_albums
      album = Album.find_by_title(@audio_tag.album)
      if album
        @audio.album_audio.where(album_id: album.id).each do |aa|
          aa.album_order = @audio_tag.track
          aa.save
        end
      end
    end
  end


  def set_conditionals_update_event_order
    if @audio.does_have_events
      event = Event.find_by_title(@audio_tag.album)
      if event
        @audio.event_audio.where(event_id: event.id).each do |ea|
          ea.event_order = @audio_tag.track
          ea.save
        end
      end
    end
  end


end



# NOTE: Obsolete, how to find duration_cents
# audio.duration_cents = m4a.audio_properties.length_in_milliseconds.divmod(1000)[1].fdiv(10).round
