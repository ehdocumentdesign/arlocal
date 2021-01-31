class AudioId3Builder


  #TODO: THIS IS ALL OBSOLETE!!!!!


  # require 'mediainfo'
  #
  # def initialize(audio)
  #   @action = nil
  #   @audio = audio
  #   @mediainfo = nil
  # end
  #
  #
  # public
  #
  #
  # def import
  #   @action = :create
  #   if File.exists?(audio_catalog_path)
  #     audio_taglib_read(audio_catalog_path)
  #   end
  #   return @audio
  # end
  #
  #
  # def import_to_album
  #   @action = :create_on_album
  #   if File.exists?(audio_catalog_path)
  #     audio_taglib_read(audio_catalog_path)
  #   end
  #   return @audio
  # end
  #
  #
  # def import_to_event
  #   @action = :create_on_event
  #   if File.exists?(audio_catalog_path)
  #     audio_taglib_read(audio_catalog_path)
  #   end
  #   return @audio
  # end
  #
  #
  # def upload
  #   @action = :create
  #   @audio.recording.open do |blob|
  #     audio_taglib_read(blob.path)
  #   end
  #   return @audio
  # end
  #
  #
  # def upload_to_album
  #   @action = :create_on_album
  #   @audio.recording.open do |blob|
  #     audio_taglib_read(blob.path)
  #   end
  #   return @audio
  # end
  #
  #
  # def upload_to_event
  #   @action = :create_on_event
  #   @audio.recording.open do |blob|
  #     audio_taglib_read(blob.path)
  #   end
  #   return @audio
  # end
  #
  #
  # def refresh
  #   @action = :update
  #   case @audio.file_source_type
  #   when :attachment
  #     @audio.recording.open do |blob|
  #       audio_taglib_read(blob.path)
  #     end
  #   when :catalog
  #     if File.exists?(audio_catalog_path)
  #       audio_taglib_read(audio_catalog_path)
  #     end
  #   end
  #   return @audio
  # end
  #
  #
  #
  # private
  #
  #
  # def audio_catalog_path
  #   File.absolute_path(CatalogHelper.catalog_audio_filesystem_path(@audio))
  # end
  #
  #
  # def audio_taglib_read(path)
  #   @mediainfo = MediaInfo.from(path)
  #   set_basics
  #   set_conditionals
  # end
  #
  #
  # def set_basics
  #   @audio.audio_artist = "#{@mediainfo.general.performer}"
  #   @audio.copyright_text_markup = "© #{@mediainfo.general.recorded_date}"
  #   @audio.title = "#{@mediainfo.general.track}"
  #   @audio.duration_mins = @mediainfo.general.duration.divmod(1000)[0].divmod(60)[0]
  #   @audio.duration_secs = @mediainfo.general.duration.divmod(1000)[0].divmod(60)[1]
  #   @audio.duration_mils = @mediainfo.general.duration.divmod(1000)[1]
  # end
  #
  #
  # def set_conditionals
  #   case @action
  #   when :create_on_album
  #     set_conditionals_create_album_order
  #   when :create_on_event
  #     set_conditionals_create_event_order
  #   when :update
  #     set_conditionals_update_album_order
  #     set_conditionals_update_event_order
  #   end
  # end
  #
  #
  # def set_conditionals_create_album_order
  #   @audio.album_audio.first.album_order = @mediainfo.general.track_position
  # end
  #
  #
  # def set_conditionals_create_event_order
  #   @audio.event_audio.first.event_order = @mediainfo.general.track_position
  # end
  #
  #
  # def set_conditionals_update_album_order
  #   if @audio.does_have_albums
  #     album = Album.find_by_title(@mediainfo.general.album)
  #     if album
  #       @audio.album_audio.where(album_id: album.id).each do |aa|
  #         aa.album_order = @mediainfo.general.track_position
  #         aa.save
  #       end
  #     end
  #   end
  # end
  #
  #
  # def set_conditionals_update_event_order
  #   if @audio.does_have_events
  #     event = Event.find_by_title(@mediainfo.general.album)
  #     if event
  #       @audio.event_audio.where(event_id: event.id).each do |ea|
  #         ea.event_order = @mediainfo.general.track_position
  #         ea.save
  #       end
  #     end
  #   end
  # end


end
