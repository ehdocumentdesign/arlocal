class Audio < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  before_validation :strip_whitespace_edges_from_entered_text

  validates :duration_hrs, allow_blank: true, numericality: { only_integer: true }
  validates :duration_mins, allow_blank: true, length: { maximum: 3 }, numericality: { only_integer: true }
  validates :duration_secs, allow_blank: true, length: { maximum: 3 }, numericality: { only_integer: true }
  validates :duration_mils, allow_blank: true, length: { maximum: 3 }, numericality: { only_integer: true }
  validates :isrc_country_code, allow_blank: true, length: { is: 2 }
  validates :isrc_designation_code, allow_blank: true, length: { is: 5 }, uniqueness: { scope: :isrc_year_of_reference }
  validates :isrc_registrant_code, allow_blank: true, length: { is: 3 }
  validates :isrc_year_of_reference, allow_blank: true, length: { is: 2 }

  has_many :album_audio, dependent: :destroy
  has_many :albums, through: :album_audio do
    def order_by_title_asc
      order(title_downcase: :asc)
    end
  end

  has_many :audio_keywords, dependent: :destroy
  has_many :keywords, through: :audio_keywords do
    def order_by_title_asc
      order(title_downcase: :asc)
    end
  end

  has_many :event_audio, dependent: :destroy
  has_many :events, through: :event_audio

  has_one_attached :source_attachment

  accepts_nested_attributes_for :album_audio, allow_destroy: true
  accepts_nested_attributes_for :audio_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }
  accepts_nested_attributes_for :event_audio, allow_destroy: true



  protected


  def self.source_type_options
    [:attachment, :catalog]
  end


  def self.source_type_options_for_select
    Audio.source_type_options.map{ |option| [option, option] }
  end



  public


  ### artist


  ### audio_artist


  ### albums_count


  ### composer


  ### copright_parser_id


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ### copyright_text_markup


  ### created_at



  ### date_released



  ### description_parser_id


  def description_props
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end


  ### description_text_markup


  def does_have_albums
    albums_count.to_i > 0
  end


  def does_have_attached(attribute)
    case attribute
    when :recording
      self.source_attachment.attached? == true
    end
  end


  def does_have_events
    events_count.to_i > 0
  end


  def does_have_keywords
    keywords_count.to_i > 0
  end


  def does_have_subtitle
    subtitle.to_s.length > 0
  end


  def does_not_have_attached(attribute)
    case attribute
    when :source_attachment
      self.source_attachment.attached? == false
    end
  end


  def duration_as_text(precision: :seconds, round_to_seconds: true)
    result = ''
    case precision
    when :minutes
      mins = duration_mins
      if duration_secs >= 30
        mins = mins + 1
      end
      result = "#{mins.to_s}"
    when :seconds
      mins = duration_mins
      secs = duration_secs
      if duration_mils >= 500
        secs = secs + 1
      end
      result = "#{mins}:#{secs.to_s.rjust(2, '0')}"
    when :cents
      mins = duration_mins
      secs = duration_secs
      cents = duration_mils.fdiv(10).round
      result = "#{mins}:#{secs.to_s.rjust(2, '0')}.#{cents.to_s.rjust(2, '0')}"
    when :milliseconds
      mins = duration_mins
      secs = duration_secs
      mils = duration_mils
      result = "#{mins}:#{secs.to_s.rjust(2, '0')}.#{mils.to_s.rjust(3, '0')}"
    else
      result = "duration_as_text"
    end
    result
  end


  ### duration_hrs


  ### duration_mins


  ### duration_secs


  ### duration_mils


  # combines and formats title, subtitle
  def full_title
    full_title = ''
    if subtitle && !subtitle.blank?
      full_title = "#{title} (#{subtitle})"
    else
      full_title = title
    end
    full_title
  end


  def has_albums
    does_have_albums
  end


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### indexed


  ### involved_people_parser_id


  def involved_people_props
    { parser_id: involved_people_parser_id, text_markup: involved_people_text_markup }
  end


  ### involved_people_text_markup


  def isrc
    [isrc_country_code, isrc_registrant_code, isrc_year_of_reference, isrc_designation_code].join
  end


  def isrc_hyphenated
    [isrc_country_code, isrc_registrant_code, isrc_year_of_reference, isrc_designation_code].join('-')
  end


  ### isrc_country_code


  ### isrc_designation_code


  ### isrc_registrant_code


  ### isrc_year_of_reference


  ### keywords_count


  ### musicians_parser_id


  def musicians_props
    { parser_id: musicians_parser_id, text_markup: musicians_text_markup }
  end


  ### musicians_text_markup


  ### published


  ### recording


  def should_generate_new_friendly_id?
    date_released_changed? ||
    source_attachment.changed? ||
    subtitle_changed? ||
    title_changed? ||
    super
  end


  def slug_candidates
    [
      [:title],
      [:title, :subtitle],
      [:title, :subtitle, :year]
    ]
  end


  def source_attachment_file_path
    if source_attachment.attached?
      source_attachment.blob.filename.to_s
    end
  end


  ### source_catalog_file_path


  def source_file_extname
    File::extname(source_file_path.to_s)
  end


  def source_file_extension
    source_file_extname.to_s.gsub(/\A./,'')
  end


  def source_file_mime_type
    Mime::Type.lookup_by_extension(source_file_extension)
  end


  def source_file_path
    case source_type
    when 'attachment'
      source_attachment_file_path
    when 'catalog'
      source_catalog_file_path
    when 'url'
      false
    end
  end


  def source_is_file
    case source_type
    when 'attachment'
      true
    when 'catalog'
      true
    else
      false
    end
  end


  def source_is_url
    case source_type
    when 'url'
      true
    else
      false
    end
  end


  ### source_type


  ### subtitle


  def title
    if super.to_s == ''
      '(untitled)'
    else
      super
    end
  end


  def title_downcase
    title.downcase
  end


  def update_and_recount_joined_resources(audio_params)
    Audio.reset_counters(id, :albums, :keywords)
    update(audio_params)
  end


  ### updated_at


  def year
    if date_released
      date_released.year
    end
  end



  private


  def strip_whitespace_edges_from_entered_text
    [ self.audio_artist,
      self.composer,
      self.copyright_text_markup,
      self.description_text_markup,
      self.involved_people_text_markup,
      self.musicians_text_markup,
      self.source_catalog_file_path,
      self.subtitle,
      self.title
    ].select { |a| String === a }.each { |a| a.strip! }
  end


end
