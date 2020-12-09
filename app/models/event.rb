class Event < ApplicationRecord


  extend MarkupParserUtils
  extend Neighborable
  include Seedable


  before_validation :strip_whitespace_edges_from_entered_text
  before_validation :ensure_critical_attributes_have_default_values

  validates :details_parser_id, presence: true
  validates :event_pictures_sorter_id, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\_\-]*\z/ }
  validates :datetime_year, presence: true
  validates :datetime_month, presence: true
  validates :datetime_day, presence: true
  validates :title_text_markup, presence: true
  validates :venue, presence: true

  before_save :convert_datetime_to_utc

  has_many :event_audio, -> { order(:event_order).includes(:audio) }, dependent: :destroy
  has_many :audio, through: :event_audio

  has_many :event_pictures, -> { includes(:picture) }, dependent: :destroy
  has_many :pictures, through: :event_pictures do
    def order_by_filename_asc
      order(filename: :asc)
    end
  end
  has_one :coverpicture, -> { where is_coverpicture: true }, class_name: 'EventPicture'

  has_many :event_keywords, dependent: :destroy
  has_many :keywords, through: :event_keywords

  accepts_nested_attributes_for :event_audio, allow_destroy: true
  accepts_nested_attributes_for :event_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }
  accepts_nested_attributes_for :event_pictures, allow_destroy: true



  public


  ### alert


  ### audio


  def audio_published
    audio.select { |a| a.published == true }
  end


  ### city


  def coverpicture_catalog_file_path
    if does_have_coverpicture
      coverpicture.picture.catalog_file_path
    end
  end


  def coverpicture_picture
    if does_have_coverpicture
      coverpicture.picture
    end
  end


  def coverpicture_slug
    if does_have_coverpicture
      coverpicture.picture.slug
    end
  end


  ### created_at


  def date_and_venue
    datetime_formatted(:year_month_day) + ' @ ' + venue
  end


  def datetime
    Time.new(
      datetime_year.to_i,
      datetime_month.to_i,
      datetime_day.to_i,
      datetime_hour.to_i,
      datetime_min.to_i,
      datetime_zone
    )
  end


  def datetime_formatted(format)
    datetime.to_s(format)
  end


  ### datetime_year
  ### datetime_month
  ### datetime_day
  ### datetime_hour
  ### datetime_min
  ### datetime_zone


  def datetime_and_title
    "#{datetime_formatted(:year_month_day)} / #{title}"
  end


  ### details_parser_id


  def details_props
    { parser_id: details_parser_id, text_markup: details_text_markup  }
  end


  ### details_text_markup


  def does_have_audio
    audio_count.to_i > 0
  end


  def does_have_alert
    alert.to_s != ''
  end


  def does_have_city
    city.to_s != ''
  end


  def does_have_city_and_venue
    does_have_city && does_have_venue
  end


  def does_have_coverpicture
    (coverpicture) && (coverpicture.picture)
  end


  def does_have_keywords
    keywords_count.to_i > 0
  end


  def does_have_map_url
    map_url.to_s != ''
  end


  def does_have_more_than_one_audio
    audio_count.to_i > 1
  end


  def does_have_more_than_one_picture
    pictures_count.to_i > 1
  end


  def does_have_pictures
    pictures_count.to_i > 0
  end


  def does_have_venue
    venue.to_s != ''
  end


  def does_have_venue_url
    venue_url.to_s != ''
  end


  ### event_audio


  def event_audio_all
    event_audio
  end


  def event_audio_published
    event_audio.select { |ea| ea.audio.published == true }
  end


  # @event.event_pictures should return a collection of pictures, ordered by a selectable method (e.g., title asc, title desc, date asc, date desc, manual order, etc.). `event_pictures` is the preferred method for administrative forms that invoke joined pictures because manual ordering requires an attribute on the join table, a value that is lost by calling @event.pictures. If the pictures are not ordered correctly, the display may lose meaning. The current solution for this challenge is to monkeypatch @event.event_pictures by calling the ordering method against super.
  # @event.pictures, on the other hand, receives its collection via the singleton ActiveRecord declaration `has_many :pictures`, rather than the instance method. Monkeypatching @event.pictures will break the class method Event.reset_counters(@event), and perhaps more.
  # @event.pictures_sorted provides the same picture order as @event.event_pictures, but returns only the picture, not the join_table intermediary (or its specific attributes).
  def event_pictures
    unsorted_pictures = super
    if event_pictures_sorter
      event_pictures_sorter.call(unsorted_pictures)
    else
      unsorted_pictures
    end
  end


  def event_pictures_all
    event_pictures
  end


  def event_pictures_published
    event_pictures.select { |ep| ep.picture.published == true }
  end


  def event_pictures_sorter
    SorterEventPictures.find(event_pictures_sorter_id)
  end


  ### event_pictures_sorter_id


  ### id


  def id_admin
    slug
  end


  def id_public
    slug
  end


  ### indexed


  ### keywords_count


  ### map_url


  ### pictures


  def pictures_all
    pictures
  end


  def pictures_all_sorted
    pictures_sorted
  end


  ### pictures_count


  def pictures_published
    pictures.select { |p| p.published == true }
  end


  def pictures_published_sorted
    event_pictures_published.map { |ep| ep.picture }
  end


  # @event.event_pictures should return a collection of pictures, ordered by a selectable method (e.g., title asc, title desc, date asc, date desc, manual order, etc.). `event_pictures` is the preferred method for administrative forms that invoke joined pictures because manual ordering requires an attribute on the join table, a value that is lost by calling @event.pictures. If the pictures are not ordered correctly, the display may lose meaning. The current solution for this challenge is to monkeypatch @event.event_pictures by calling the ordering method against super.
  # @event.pictures, on the other hand, receives its collection via the singleton ActiveRecord declaration `has_many :pictures`, rather than the instance method. Monkeypatching @event.pictures will break the class method Event.reset_counters(@event), and perhaps more.
  # @event.pictures_sorted provides the same picture order as @event.event_pictures, but returns only the picture, not the join_table intermediary (or its specific attributes).
  def pictures_sorted
    event_pictures.map { |ep| ep.picture }
  end


  ### published


  ### show_can_cycle_pictures


  ### show_can_have_more_pictures_link


  def show_will_cycle_pictures
    show_can_cycle_pictures && does_have_more_than_one_picture
  end


  def show_will_have_more_pictures_link
    show_can_have_more_pictures_link && does_have_more_than_one_picture
  end


  ### slug


  def slug_source
    :start_time_and_venue
  end


  def title
    title_text_markup
  end


  ### title_text_markup


  ### updated_at


  def update_and_recount_joined_resources(event_params)
    Event.reset_counters(id, :pictures, :keywords)
    update(event_params)
  end


  ### updated_at


  ### venue


  ### venue_url



  private


  def convert_datetime_to_utc
    self.datetime_utc = self.datetime.utc
  end


  def ensure_critical_attributes_have_default_values
    if self.slug.to_s == ''
      self.slug = self.datetime.to_s(:year_month_day).parameterize + '-' + self.venue.parameterize
    end
  end


  def strip_whitespace_edges_from_entered_text
    [ self.alert,
      self.city,
      self.details_text_markup,
      self.map_url,
      self.title_text_markup,
      self.slug,
      self.venue,
      self.venue_url
    ].each { |a| a.to_s.strip! }
  end


end
