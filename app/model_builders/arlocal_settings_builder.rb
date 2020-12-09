class ArlocalSettingsBuilder


  def build_and_save_default
    if ArlocalSettings.first
      Rails.logger.warn 'ARLOCAL: Database entry for ArlocalSettings resource already exists.'
    else
      arlocal_settings = default
      arlocal_settings.save
      arlocal_settings
    end
  end


  def default
    ArlocalSettings.new(params_default)
  end


  def params_default
    {
      admin_forms_edit_slug_field: true,
      admin_forms_auto_keyword_enabled: false,
      admin_forms_auto_keyword_id: nil,
      admin_forms_selectable_pictures_sorter_id: SorterFormSelectablePictures.find_by_symbol(:all_title_asc).id,
      admin_index_albums_sorter_id: SorterIndexAdminAlbums.find_by_symbol(:title_asc).id,
      admin_index_audio_sorter_id: SorterIndexAdminAudio.find_by_symbol(:filepath_asc).id,
      admin_index_events_sorter_id: SorterIndexAdminEvents.find_by_symbol(:datetime_asc).id,
      admin_index_pictures_sorter_id: SorterIndexAdminPictures.find_by_symbol(:filepath_asc).id,
      artist_name: 'your name here',
      marquee_enabled: false,
      marquee_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      marquee_text_markup: '',
      html_head_public_can_include_meta_description: true,
      html_head_favicon_catalog_filepath: '',
      public_index_albums_sorter_id: SorterIndexPublicAlbums.find_by_symbol(:datetime_asc).id,
      public_index_audio_sorter_id: SorterIndexPublicAudio.find_by_symbol(:filepath_asc).id,
      public_index_events_sorter_id: SorterIndexPublicEvents.find_by_symbol(:upcoming).id,
      public_index_pictures_sorter_id: SorterIndexPublicPictures.find_by_symbol(:datetime_asc).id,
      public_nav_can_include_albums: true,
      public_nav_can_include_audio: false,
      public_nav_can_include_events: true,
      public_nav_can_include_info: true,
      public_nav_can_include_pictures: true
    }
  end


end
