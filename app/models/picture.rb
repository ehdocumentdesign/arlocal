class Picture < ApplicationRecord

  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  before_validation :strip_whitespace_edges_from_entered_text
  before_validation :strip_any_leading_slash_from_catalog_file_path
  before_validation :create_attr_title_without_markup

  validates :credits_parser_id, presence: true
  validates :description_parser_id, presence: true
  validates :title_parser_id, presence: true

  has_many :album_pictures, dependent: :destroy
  has_many :albums, through: :album_pictures do
    def order_by_title_asc
      order(Album.arel_table[:title].lower.asc)
    end
  end

  has_many :event_pictures, dependent: :destroy
  has_many :events, through: :event_pictures

  has_many :picture_keywords, dependent: :destroy
  has_many :keywords, through: :picture_keywords do
    def order_by_title_asc
      order(Keyword.arel_table[:title].lower.asc)
    end
  end

  has_one_attached :image


  accepts_nested_attributes_for :album_pictures, allow_destroy: true
  accepts_nested_attributes_for :event_pictures, allow_destroy: true
  accepts_nested_attributes_for :picture_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }



  protected


  def self.source_type_options
    [:attachment, :catalog]
  end


  def self.source_type_options_for_select
    Picture.source_type_options.map{ |option| [option, option] }
  end


  public


  ### albums_count


  ### created_at


  ### credits_parser_id


  def credits_props
    { parser_id: credits_parser_id, text_markup: credits_text_markup }
  end


  ### credits_text_markup


  def datetime
    datetime_effective_value
  end


  ### datetime_cascade_method


  ### datetime_cascade_value


  def datetime_effective_method
    if datetime_from_manual_entry.to_s != ''
      'manual entry'
    elsif datetime_from_exif.to_s != ''
      'picture EXIF data'
    elsif datetime_from_file.to_s != ''
      'file date/time'
    else
      'unknown'
    end
  end


  def datetime_effective_value
    case datetime_effective_method
    when 'manual entry'
      datetime_from_manual_entry
    when 'picture EXIF data'
      datetime_from_exif
    when 'file date/time'
      datetime_from_file
    when 'unknown'
      Time.new(0)
    end
  end



  def datetime_from_manual_entry
    if datetime_from_manual_entry_array_to_best_precision.any?
      DateTime.new(*datetime_from_manual_entry_array_to_best_precision).strftime('%Y-%m-%d %H:%M:%S')
    end
  end


  def datetime_from_manual_entry_array
    h = datetime_from_manual_entry_hash
    [
      h[:year],
      h[:month],
      h[:day],
      h[:hour],
      h[:minute],
      h[:second]
    ]
  end


  def datetime_from_manual_entry_array_to_best_precision
    a = datetime_from_manual_entry_array
    a[0...a.find_index(nil)]
  end


  def datetime_from_manual_entry_hash
    h = {
      year: datetime_from_manual_entry_year,
      month: datetime_from_manual_entry_month,
      day: datetime_from_manual_entry_day,
      hour: datetime_from_manual_entry_hour,
      minute: datetime_from_manual_entry_minute,
      second: datetime_from_manual_entry_second
    }
    h.delete_if { |k,v| v.to_s == "" }
  end


  ### datetime_from_manual_entry_year


  ### datetime_from_manual_entry_month


  ### datetime_from_manual_entry_day


  ### datetime_from_manual_entry_hour


  ### datetime_from_manual_entry_minute


  ### datetime_from_manual_entry_second


  ### datetime_from_exif


  ### datetime_from_file


  def datetime_year
    case datetime
    when String
      Date.parse(datetime).year
    when Time
      datetime.year
    end
  end


  ### description_parser_id


  def description_props
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end


  ### description_text_markup


  ### events_count


  def does_have_albums
    albums_count.to_i > 0
  end


  def does_have_attached(attribute)
    case attribute
    when :image
      self.image.attached? == true
    end
  end


  def does_have_credits
    credits_text_markup.to_s != ''
  end


  def does_have_datetime
    datetime != Time.new(0)
  end


  def does_have_description
    description_text_markup != ''
  end


  def does_have_events
    events_count.to_i > 0
  end


  def does_have_keywords
    keywords_count.to_i > 0
  end


  def does_have_title
    title_text_markup.to_s != ''
  end


  def does_not_have_attached(attribute)
    case attribute
    when :image
      self.image.attached? == false
    end
  end


  def does_not_have_slug
    (slug == nil) || (slug.to_s == '')
  end


  def does_not_have_title
    (title == nil) || (title.to_s == '')
  end


  def filename
    source_file_path
  end


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### indexed


  ### keywords_count


  ### picture_keywords


  ### published


  def should_generate_new_friendly_id?
    datetime_from_exif_changed? ||
    datetime_from_file_changed? ||
    datetime_from_manual_entry_year_changed? ||
    datetime_from_manual_entry_month_changed? ||
    datetime_from_manual_entry_day_changed? ||
    datetime_from_manual_entry_hour_changed? ||
    datetime_from_manual_entry_minute_changed? ||
    datetime_from_manual_entry_second_changed? ||
    image.changed? ||
    source_catalog_file_path_changed? ||
    source_type_changed? ||
    super
  end


  ### show_can_display_title


  def show_will_display_title
    show_can_display_title && does_have_title
  end


  ### slug


  def slug_candidates
    [
      [:source_file_basename],
      [:source_file_basename, :datetime ]
    ]
  end


  def source_attachment_file_path
    if image.attached?
      image.blob.filename.to_s
    else
      ''
    end
  end


  ### source_catalog_file_path


  def source_file_basename
    if source_file_path
      File.basename(source_file_path, '.*')
    end
  end


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
      source_url
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


  def title
    if title_without_markup.to_s == ''
      '(untitled)'
    else
      title_without_markup
    end
  end


  ### title_parser_id


  def title_props
    { parser_id: title_parser_id, text_markup: title_text_markup }
  end


  ### title_text_markup


  ### title_without_markup


  def title_without_markup_downcase
    title_without_markup.downcase
  end


  def update_and_recount_joined_resources(picture_params)
    Picture.reset_counters(id, :albums, :events, :keywords)
    update(picture_params)
  end


  ### updated_at



  private


  def create_attr_title_without_markup
    self.title_without_markup = ApplicationController.helpers.parser_remove_markup(self.title_props)
  end


  def strip_any_leading_slash_from_catalog_file_path
    if self.source_catalog_file_path[0] == '/'
      self.source_catalog_file_path[0] = ''
    end
  end


  def strip_whitespace_edges_from_entered_text
    [ self.credits_text_markup,
      self.description_text_markup,
      self.title_text_markup,
      self.source_catalog_file_path
    ].each { |a| a.to_s.strip! }
  end



end
