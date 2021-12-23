class Album < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  before_validation :strip_whitespace_edges_from_entered_text

  validates :album_pictures_sorter_id, presence: true
  validates :description_parser_id, presence: true
  validates :date_released, presence: true
  validates :title, presence: true

  has_many :album_audio, -> { order(:album_order).includes(:audio) }, dependent: :destroy
  has_many :audio, through: :album_audio

  has_many :album_keywords, dependent: :destroy
  has_many :keywords, through: :album_keywords

  has_many :album_pictures, -> { includes(:picture) }, dependent: :destroy
  has_many :pictures, through: :album_pictures do
    def order_by_filename_asc
      order(filename: :asc)
    end
  end
  has_one :coverpicture, -> { where is_coverpicture: true }, class_name: 'AlbumPicture'

  accepts_nested_attributes_for :album_audio, allow_destroy: true
  accepts_nested_attributes_for :album_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }
  accepts_nested_attributes_for :album_pictures, allow_destroy: true
  accepts_nested_attributes_for :audio
  accepts_nested_attributes_for :pictures



  public


  ### album_artist


  ### album_audio


  def album_audio_all
    album_audio
  end


  def album_audio_published
    album_audio.select { |aa| aa.audio.published == true }
  end


  # @album.album_pictures should return a collection of pictures, ordered by a selectable method (e.g., title asc, title desc, date asc, date desc, manual order, etc.). `album_pictures` is the preferred method for administrative forms that invoke joined pictures because manual ordering requires an attribute on the join table, a value that is lost by calling @album.pictures. If the pictures are not ordered correctly, the display may lose meaning. The current solution for this challenge is to monkeypatch @album.album_pictures by calling the ordering method against super.
  # @album.pictures, on the other hand, receives its collection via the singleton ActiveRecord declaration `has_many :pictures`, rather than the instance method. Monkeypatching @album.pictures will break the class method Album.reset_counters(@album), and perhaps more.
  # @album.pictures_sorted provides the same picture order as @album.album_pictures, but returns only the picture, not the join_table intermediary (nor its specific attributes).
  def album_pictures
    unsorted_pictures = super
    if album_pictures_sorter
      album_pictures_sorter.call(unsorted_pictures)
    else
      unsorted_pictures
    end
  end


  def album_pictures_all
    album_pictures
  end


  def album_pictures_published
    album_pictures.select { |ap| ap.picture.published == true }
  end


  def album_pictures_sorter
    SorterAlbumPictures.find(album_pictures_sorter_id)
  end


  ### album_pictures_sorter_id


  ### artist


  ### audio


  ### audio_count


  def audio_published
    audio.select { |a| a.published == true }
  end


  ### copyright_parser_id


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ### copyright_text_markup


  def coverpicture_catalog_file_path
    if does_have_coverpicture
      coverpicture.picture_catalog_file_path
    end
  end


  def coverpicture_picture
    if does_have_coverpicture
      coverpicture.picture
    end
  end


  def coverpicture_picture_id
    if does_have_coverpicture
      coverpicture.picture.id
    end
  end


  def coverpicture_slug
    if does_have_coverpicture
      coverpicture.picture.slug
    end
  end


  ### created_at


  ### date_released


  ### description_parser_id


  def description_props
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end


  ### description_text_markup


  #### TODO: no calls?
  def does_have_album_artist
    album_artist.to_s != ''
  end


  def does_have_alt_url
    alt_url.to_s != ''
  end


  def does_have_audio
    audio_count.to_i > 0
  end


  def does_have_coverpicture
    coverpicture && coverpicture.picture
  end


  def does_have_description
    description_text_markup.to_s != ''
  end


  def does_have_involved_people
    involved_people_text_markup.to_s != ''
  end


  #### TODO: no calls?
  def does_have_more_than_one_audio
    audio_count.to_i > 1
  end


  def does_have_more_than_one_picture
    pictures_count.to_i > 1
  end


  def does_have_musicians
    musicians_text_markup.to_s != ''
  end


  def does_have_pictures
    pictures_count.to_i > 0
  end


  def does_have_keywords
    keywords_count.to_i > 0
  end


  def does_have_pictures_sorter_id
    pictures_sorter_id.to_s != ''
  end


  def does_have_vendor_widget_gumroad
    vendor_widget_gumroad.to_s != ''
  end


  def does_not_have_alt_url
    alt_url.to_s == ''
  end


  def duration(round_to_seconds: true)
    mins = 0
    secs = 0
    mils = 0
    audio.each do |a|
      mins += a.duration_mins
      secs += a.duration_secs
      mils += a.duration_mils
    end
    while mils >= 1000
      mils -= 1000
      secs += 1
    end
    secs += 1 if mils >= 500 && round_to_seconds == true
    while secs >= 60
      secs -= 60
      mins += 1
    end
    "#{mins}:#{secs.to_s.rjust(2, '0')}"
  end


  ### duration_mins


  ### duration_secs


  ### duration_mils


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### index_can_display_tracklist


  ### index_tracklist_audio_includes_subtitles


  def index_will_display_tracklist
    index_can_display_tracklist && does_have_audio
  end


  ### indexed


  ### involved_people_parser_id


  def involved_people_props
    { parser_id: involved_people_parser_id, text_markup: involved_people_text_markup }
  end


  ### involved_people_text_markup


  ### keywords


  ### keywords_count


  ### musicians_parser_id


  def musicians_props
    { parser_id: musicians_parser_id, text_markup: musicians_text_markup }
  end


  ### musicians_text_markup


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
    album_pictures_published.map { |ap| ap.picture }
  end


  # @album.album_pictures should return a collection of pictures, ordered by a selectable method (e.g., title asc, title desc, date asc, date desc, manual order, etc.). `album_pictures` is the preferred method for administrative forms that invoke joined pictures because manual ordering requires an attribute on the join table, a value that is lost by calling @album.pictures. If the pictures are not ordered correctly, the display may lose meaning. The current solution for this challenge is to monkeypatch @album.album_pictures by calling the ordering method against super.
  # @album.pictures, on the other hand, receives its collection via the singleton ActiveRecord declaration `has_many :pictures`, rather than the instance method. Monkeypatching @album.pictures will break the class method Album.reset_counters(@album), and perhaps more.
  # @album.pictures_sorted provides the same picture order as @album.album_pictures, but returns only the picture, not the join_table intermediary (or its specific attributes).
  def pictures_sorted
    album_pictures.map { |ap| ap.picture }
  end


  ### published


  def should_generate_new_friendly_id?
    date_released_changed? ||
    title_changed? ||
    super
  end


  ### show_can_cycle_pictures


  ### show_can_have_more_pictures_link


  ### show_can_have_vendor_widget_gumroad


  def show_will_cycle_pictures
    show_can_cycle_pictures && does_have_more_than_one_picture
  end


  def show_will_display_vendor_link
    false
  end


  def show_will_have_more_pictures_link
    show_can_have_more_pictures_link && does_have_more_than_one_picture
  end


  def show_will_have_vendor_widget_gumroad
    show_can_have_vendor_widget_gumroad && does_have_vendor_widget_gumroad
  end


  def show_will_link_to_alt_url
    show_can_link_to_alt_url && does_have_alt_url
  end


  def show_will_not_link_to_alt_url
    show_will_link_to_alt_url != true
  end


  ### slug


  def slug_candidates
    [
      [:title],
      [:title, :year]
    ]
  end


  ### title


  def title_downcase
    title.downcase
  end


  def update_and_recount_joined_resources(album_params)
    Album.reset_counters(id, :audio, :pictures, :keywords)
    update(album_params)
  end


  ### updated_at


  def year
    date_released.year
  end



  private


  def strip_whitespace_edges_from_entered_text
    [ self.album_artist,
      self.copyright_text_markup,
      self.description_text_markup,
      self.involved_people_text_markup,
      self.musicians_text_markup,
      self.title,
      self.vendor_widget_gumroad
    ].select{ |a| a.to_s != '' }.each { |a| a.to_s.strip! }
  end


end
