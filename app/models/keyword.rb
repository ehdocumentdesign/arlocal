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


  ### albums_count


  ### audio_count


  ### events_count


  ### can_select_pictures


  def can_select(resource_type: nil)
    case resource_type.to_s.downcase.singularize
    when 'picture'
      can_select_pictures
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


  # unique index id for database
  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### pictures_count


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
    [ self.title
    ].each { |a| a.to_s.strip! }
  end


end
