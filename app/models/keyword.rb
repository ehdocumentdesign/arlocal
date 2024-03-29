class Keyword < ApplicationRecord


  extend FriendlyId
  extend Neighborable
  include Seedable


  friendly_id :slug_candidates, use: :slugged

  before_validation :strip_whitespace_edges_from_entered_text

  validates :title, presence: true, uniqueness: true


  has_many :album_keywords, dependent: :destroy
  has_many :albums, through: :album_keywords do
    def order_by_title_asc
      order(Album.arel_table[:title].lower.asc)
    end
  end

  has_many :audio_keywords, dependent: :destroy
  has_many :audio, through: :audio_keywords do
    def order_by_title_asc
      order(Audio.arel_table[:title].lower.asc)
      sort_by { |a| a.full_title }
    end
  end

  has_many :event_keywords, dependent: :destroy
  has_many :events, through: :event_keywords do
    def order_by_start_time_asc
      order(start_time: :asc)
    end
    def order_by_start_time_desc
      order(start_time: :desc).reverse
    end
  end

  has_many :picture_keywords, dependent: :destroy
  has_many :pictures, through: :picture_keywords do
    def order_by_filename_asc
      order(filename: :asc)
    end
    def order_by_slug_asc
      order(Picture.arel_table[:slug].lower.asc)
    end
  end

  has_many :video_keywords, dependent: :destroy
  has_many :videos, through: :video_keywords

  accepts_nested_attributes_for :album_keywords, allow_destroy: true
  accepts_nested_attributes_for :audio_keywords, allow_destroy: true
  accepts_nested_attributes_for :event_keywords, allow_destroy: true
  accepts_nested_attributes_for :picture_keywords, allow_destroy: true
  accepts_nested_attributes_for :video_keywords, allow_destroy: true



  public


  def albums_by_title
    albums.sort_by{ |a| a.title }
  end


  ### albums_count


  def audio_by_title
    audio.sort_by{ |a| a.full_title }
  end


  ### audio_count


  ### can_select_albums


  ### can_select_events


  ### can_select_pictures


  ### can_select_videos


  def can_select(resource_type)
    case resource_type.to_s.downcase.pluralize
    when 'albums'
      can_select_albums
    when 'events'
      can_select_albums
    when 'pictures'
      can_select_pictures
    when 'videos'
      can_select_videos
    end
  end


  ### created_at


  def does_have_albums
    albums_count.to_i > 0
  end


  def does_have_audio
    audio_count.to_i > 0
  end


  def does_have_events
    events_count.to_i > 0
  end


  def does_have_pictures
    pictures_count.to_i > 0
  end


  def does_have_videos
    videos_count.to_i > 0
  end


  def events_by_title
    events.sort_by{ |a| a.title }
  end


  ### events_count


  # unique index id for database
  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### order_selecting_albums


  ### order_selecting_events


  ### order_selecting_pictures


  ### order_selecting_videos


  def pictures_by_title
    pictures.sort_by{ |a| a.title }
  end


  ### pictures_count


  def picture_keywords
    unordered_pictures = super
    unordered_pictures.sort_by { |kp| kp.picture.title_without_markup.downcase }
  end


  def should_generate_new_friendly_id?
    title_changed? ||
    super
  end


  ### slug


  def slug_candidates
    [
      [:title]
    ]
  end


  def slug_downcase
    slug.downcase
  end


  ### title


  def title_downcase
    title.downcase
  end


  # returns a string with title and number of joined audio
  def title_with_audio_count
    "#{title} (#{audio_count})"
  end


  # returns a string with title and number of joined pictures
  def title_with_pictures_count
    "#{self.title} (#{self.pictures_count})"
  end


  def update_and_recount_joined_resources(keyword_params)
    Keyword.reset_counters(id, :albums, :audio, :events, :pictures, :videos)
    update(keyword_params)
  end


  ### updated_at


  def videos_by_title
    videos.sort_by{ |a| a.title }
  end


  ### videos_count


  def will_select_public_pictures
    can_select_pictures && does_have_pictures
  end


  def will_select(resource_type: nil)
    case resource_type.to_s.downcase.singularize
    when 'picture'
      will_select_public_pictures
    end
  end



  private


  def strip_whitespace_edges_from_entered_text
    [ self.title ].each { |a| a.to_s.strip! }
  end


end
