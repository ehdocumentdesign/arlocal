class Picture < ApplicationRecord


  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable


  # before_validation :strip_any_leading_slash_from_catalog_file_path
  before_validation :affirm_critical_attributes
  before_validation :strip_whitespace_edges_from_entered_text
  before_validation :create_attr_title_without_markup

  validates :catalog_file_path, uniqueness: { allow_blank: true, case_sensitive: true }
  validates :credits_parser_id, presence: true
  validates :description_parser_id, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\_\-]*\z/ }
  validates :title_parser_id, presence: true

  # before_save :get_datetime_metadata


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



  ### albums_count


  # TODO: This verbage fails if additional objects become attachable.
  def attachment_file_source_path
    if does_have_attachment
      image.blob.filename.to_s
    end
  end


  def catalog_file_basename
    File.basename(catalog_file_path)
  end


  ### catalog_file_path


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


  ### filename


  def does_have_albums
    albums_count.to_i > 0
  end


  # TODO: This verbage fails if additional objects become attachable.
  def does_have_attachment
    image.attachment != nil
  end


  def does_have_catalog_file_path
    catalog_file_path.to_s.length > 0
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


  def does_not_have_attachment
    image.attachment == nil
  end


  def does_not_have_catalog_file_path
    catalog_file_path.to_s == ''
  end


  def does_not_have_slug
    (slug == nil) || (slug.to_s == '')
  end


  def does_not_have_title
    (title == nil) || (title.to_s == '')
  end


  def file_source_type
    if does_have_attachment
      :attachment
    elsif does_have_catalog_file_path
      :catalog
    else
      nil
    end
  end


  def file_source_type_is_attachment
    file_source_type == :attachment
  end


  def file_source_type_is_catalog
    file_source_type == :catalog
  end


  def file_source_path
    case file_source_type
    when :attachment
      image.blob.filename.to_s
    when :catalog
      catalog_file_path
    end
  end


  ### id


  def id_admin
    slug
  end


  def id_public
    slug
  end


  def image_file_name
    if does_have_attachment
      image.filename
    end
  end


  ### indexed


  ### keywords_count


  ### picture_keywords


  ### published


  ### show_can_display_title


  def show_will_display_title
    show_can_display_title && does_have_title
  end


  ### slug


  def slug_source
    :filename
  end


  def title
    title_without_markup
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


  def affirm_critical_attributes
    affirm_critical_attributes_slug
    affirm_critical_attributes_title
  end


  def affirm_critical_attributes_slug
    if self.does_not_have_slug
      slug = ''
      case self.file_source_type
      when :attachment
        slug = "#{self.image_file_name} #{self.datetime.to_s}"
      when :catalog
        slug = File.basename(self.catalog_file_path, '.*')
      end
      self.slug = slug.to_s.parameterize
    end
  end


  def affirm_critical_attributes_title
    if self.does_not_have_title
      self.title_text_markup = self.slug
    end
  end


  def strip_any_leading_slash_from_catalog_file_path
    if self.catalog_file_path[0] == '/'
      self.catalog_file_path[0] = ''
    end
  end


  def strip_whitespace_edges_from_entered_text
    [ self.catalog_file_path,
      self.credits_text_markup,
      self.description_text_markup,
      self.title_text_markup,
      self.slug
    ].each { |a| a.to_s.strip! }
  end



end



### TODO: These obsolete methods can probably be removed entirely.
# def ensure_critical_attributes_have_default_values
  # omit the extension from self.filename to generate slug
  # is there an easier way?
  # if self.does_not_have_slug
  #   path = File.dirname(self.catalog_file_path).to_s
  #   file = File.basename(self.catalog_file_path, File.extname(self.catalog_file_path)).to_s
  #   if path == '.'
  #     self.slug = ''
  #   else
  #     self.slug = ''
  #     # self.slug = path + '/'      # <-- uncomment to include full path name in slug
  #   end
  #   self.slug << file
  #   self.slug = slug.parameterize


  # def get_datetime_metadata
  #   if self.catalog_file_path
  #     catalog_filesystem_dirname = ArlocalEnv.artist_catalog_filesystem_dirname
  #     path_to_file = File.join(catalog_filesystem_dirname, 'images', self.catalog_file_path)
  #     if File.exists?(path_to_file)
  #       self.datetime_from_file = File.ctime(path_to_file)
  #       self.datetime_from_exif = Exiftool.new(path_to_file)[:date_time_original]
  #     end
  #     if self.datetime_from_manual_entry
  #       self.datetime_cascade_value = self.datetime_from_manual_entry.to_s
  #       self.datetime_cascade_method = 'manual entry'
  #     elsif self.datetime_from_exif
  #       d = self.datetime_from_exif.split(/\s/)
  #       d[0].gsub!(':',"-")
  #       self.datetime_cascade_value = d.join(' ')
  #       self.datetime_cascade_method = 'picture EXIF metadata'
  #     elsif self.datetime_from_file
  #       self.datetime_cascade_value = self.datetime_from_file.to_s
  #       self.datetime_cascade_method = 'file date/time'
  #     end
  #   end
  # end

  # TODO: DRY up the path_to_file File.join() method
  # def get_datetime_metadata
  #   # path_to_file = ''
  #   # case self.file_source_type
  #   # when :attachment
  #   #   path_to_file =
  #   # when :catalog
  #   #   path_to_file = CatalogHelper.catalog_picture_filesystem_path(self)
  #   # end
  #   #
  #   # if self.catalog_file_path
  #   #   catalog_filesystem_dirname = ArlocalEnv.artist_catalog_filesystem_dirname
  #   #   path_to_file = File.join(catalog_filesystem_dirname, 'images', self.catalog_file_path)
  #   #   if File.exists?(path_to_file)
  #   #     self.datetime_from_file = File.ctime(path_to_file)
  #   #     self.datetime_from_exif = Exiftool.new(path_to_file)[:date_time_original]
  #   #   end
  #     if self.datetime_from_manual_entry
  #       self.datetime_cascade_value = self.datetime_from_manual_entry.to_s
  #       self.datetime_cascade_method = 'manual entry'
  #     elsif self.datetime_from_exif
  #       d = self.datetime_from_exif.split(/\s/)
  #       d[0].gsub!(':',"-")
  #       self.datetime_cascade_value = d.join(' ')
  #       self.datetime_cascade_method = 'picture EXIF metadata'
  #     elsif self.datetime_from_file
  #       self.datetime_cascade_value = self.datetime_from_file.to_s
  #       self.datetime_cascade_method = 'file date/time'
  #     end
  #   end
  # end
