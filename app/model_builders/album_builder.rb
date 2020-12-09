class AlbumBuilder
  
    
  def default
    Album.new(params_default)
  end
  
  
  def default_with(params_given)
    params = params_default.merge(params_given)
    Album.new(params)
  end
  
  
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
