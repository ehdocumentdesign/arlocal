class ArlocalSettings < ApplicationRecord


  before_validation :strip_whitespace_edges_from_entered_text

  validates :admin_forms_auto_keyword_id, presence: true, if: :admin_forms_auto_keyword_enabled


  ### admin_index_audio_sorter_id


  ### admin_forms_auto_keyword_enabled


  ### admin_forms_auto_keyword_id


  ### admin_forms_edit_external_media_player_fields


  ### admin_forms_edit_slug_field


  ### admin_forms_retain_pane_for_neighbors


  ### admin_forms_selectable_pictures_sorter_id


  ### admin_index_pictures_sorter_id


  ### artist_content_copyright_year_earliest


  ### artist_content_copyright_year_latest


  ### artist_name


  def artist_name_downcase
    artist_name.to_s.downcase
  end


  def artist_name_capitalized
    names = artist_name.to_s.split(' ')
    names.map{ |name| name.capitalize }.join(' ')
  end


  ### audio_default_isrc_country_code


  ### audio_default_iscr_registrant_code


  ### created_at


  ### html_head_favicon_catalog_filepath


  ### html_head_google_analytics_id


  ### html_head_public_can_include_google_analytics


  ### html_head_public_can_include_meta_description


  def html_head_public_should_include_google_analytics
    if (html_head_public_can_include_google_analytics) && (html_head_google_analytics_id.to_s != '')
      true
    end
  end


  ### id


  ### marquee_enabled


  ### marquee_parser_id


  def marquee_props
    { parser_id: marquee_parser_id, text_markup: marquee_text_markup }
  end


  ### marquee_text_markup


  def marquee_will_render
    (marquee_enabled) && (marquee_text_markup.to_s != '')
  end



  ### public_index_albums_sorter_id


  ### public_index_pictures_sorter_id


  def public_layout_will_have_nav
    public_nav_includeables.include?(true) == true
  end


  def public_layout_will_not_have_nav
    public_nav_includeables.include?(true) == false
  end


  ### public_nav_can_include_albums


  ### public_nav_can_include_audio


  ### public_nav_can_include_events


  ### public_nav_can_include_info


  ### public_nav_can_include_pictures


  ### public_nav_can_include_stream


  ### public_nav_can_include_videos


  def public_nav_includeables
    [
      public_nav_can_include_albums,
      public_nav_can_include_audio,
      public_nav_can_include_events,
      public_nav_can_include_info,
      public_nav_can_include_pictures,
      public_nav_can_include_stream,
      public_nav_can_include_videos
    ]
  end



  private


  def strip_whitespace_edges_from_entered_text
    [ self.artist_name,
      self.marquee_text_markup,
      self.html_head_favicon_catalog_filepath,
    ].each { |a| a.to_s.strip! }
  end


end
