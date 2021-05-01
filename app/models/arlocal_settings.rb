class ArlocalSettings < ApplicationRecord

  has_one_attached :icon_image

  before_validation :strip_whitespace_edges_from_entered_text

  validates :admin_forms_auto_keyword_id, presence: true, if: :admin_forms_auto_keyword_enabled



  protected


  def self.icon_source_type_options
    [:attachment, :catalog]
  end


  def self.icon_source_type_options_for_select
    ArlocalSettings.icon_source_type_options.map{ |option| [option, option] }
  end



  public


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


  def does_have_attached(attribute)
    case attribute
    when :icon_image
      self.icon_image.attached? == true
    end
  end


  def does_not_have_attached(attribute)
    case attribute
    when :icon_image
      self.icon_image.attached? == false
    end
  end


  ### html_head_google_analytics_id


  ### html_head_public_can_include_google_analytics


  ### html_head_public_can_include_meta_description


  def html_head_public_should_include_google_analytics
    if (html_head_public_can_include_google_analytics) && (html_head_google_analytics_id.to_s != '')
      true
    end
  end


  def icon_filename
    icon_source_file_path
  end


  def icon_source_attachment_file_path
    if icon_image.attached?
      icon_image.blob.filename.to_s
    else
      ''
    end
  end


  ### icon_source_catalog_file_path


  def icon_source_file_basename
    if icon_source_file_path
      File.basename(icon_source_file_path, '.*')
    end
  end


  def icon_source_file_extname
    File::extname(icon_source_file_path.to_s)
  end


  def icon_source_file_extension
    icon_source_file_extname.to_s.gsub(/\A./,'')
  end


  def icon_source_file_mime_type
    Mime::Type.lookup_by_extension(icon_source_file_extension)
  end


  def icon_source_file_path
    case icon_source_type
    when 'attachment'
      icon_source_attachment_file_path
    when 'catalog'
      icon_source_catalog_file_path
    end
  end


  def icon_source_is_file
    case source_type
    when 'attachment'
      true
    when 'catalog'
      true
    else
      false
    end
  end


  ### icon_source_type


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
      self.icon_source_catalog_file_path,
      self.marquee_text_markup,
    ].each { |a| a.to_s.strip! }
  end


end
