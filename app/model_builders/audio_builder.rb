class AudioBuilder
  

  def initialize(arlocal_settings = ArlocalSettings.first)
    @arlocal_settings = arlocal_settings
  end
  
  
  public
  
  
  def default
    Audio.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Audio.new(params)
  end
  
  
  def params_default
    {
      artist: @arlocal_settings.artist_name,
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      date_released: determine_date_released,
      description_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      indexed: true,
      involved_people_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      isrc_country_code: @arlocal_settings.audio_default_isrc_country_code,
      isrc_registrant_code: @arlocal_settings.audio_default_isrc_registrant_code,
      musicians_parser_id: MarkupParser.find_by_symbol(:no_formatting).id
    }
  end

  
  def prepare_from_import(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).import
    audio
  end
  

  def prepare_from_import_for_album(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).import_to_album
    audio
  end


  def prepare_from_import_for_event(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).import_to_event
    audio
  end

  
  def prepare_from_upload(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).upload
    audio
  end


  def prepare_from_upload_for_album(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).upload_to_album
    audio
  end


  def prepare_from_upload_for_event(params_given)
    audio = AudioId3Builder.new(default_with(params_given)).upload_to_event
    audio
  end
  
  
  def refresh_id3(audio)
    AudioId3Builder.new(audio).refresh
  end
  

  private
  
  
  def default_date_released_enabled
    @arlocal_settings && @arlocal_settings.audio_default_date_released_enabled
  end
  
  
  def determine_date_released
    if default_date_released_enabled
      @arlocal_settings.audio_default_date_released
    else
      nil
    end
  end
  
  
end


