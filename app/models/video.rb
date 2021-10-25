class Video < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  has_many :video_keywords, dependent: :destroy
  has_many :keywords, through: :video_keywords

  has_one :video_picture, dependent: :destroy
  has_one :picture, through: :video_picture

  has_one_attached :source_attachment

  accepts_nested_attributes_for :video_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }
  accepts_nested_attributes_for :video_picture, allow_destroy: true

  before_validation :strip_whitespace_edges_from_entered_text



  protected


  def self.source_type_options
    [:attachment, :catalog, :embed, :url]
  end


  def self.source_type_options_for_select
    Video.source_type_options.map{ |option| [option, option] }
  end



  public


  ### copyright_parser_id


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ### copyright_text_markup


  def coverpicture
    video_picture
  end


  def coverpicture_picture
    thumbnail.picture
  end


  ### date_released


  ### description_parser_id


  def description_props
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end


  ### description_text_markup


  def display_dimension_width
    640
  end


  def display_dimension_height
    (source_dimension_height * display_dimension_width) / source_dimension_width
  end


  def does_have_attached(attribute)
    case attribute
    when :recording
      self.source_attachment.attached? == true
    end
  end


  def does_have_coverpicture
    coverpicture != nil
  end


  def does_have_keywords
    keywords_count.to_i > 0
  end


  def does_not_have_attached(attribute)
    case attribute
    when :recording
      self.source_attachment.attached? == false
    end
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


  ### picture_id


  ### published


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


  def source_attachment_file_path
    source_attachment.blob.filename.to_s
  end


  ### source_catalog_file_path


  ### source_dimension_height


  ### source_dimension_width


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


  def source_is_embed
    case source_type
    when 'embed'
      true
    else
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


  def source_location
    case source_type
    when 'attachment'
      source_file_path
    when 'catalog'
      source_file_path
    when 'url'
      source_url
    end
  end


  ### source_type


  ### source_url


  def thumbnail
    case video_picture
    when nil
      build_video_picture
    when VideoPicture
      video_picture
    end
  end


  ### title


  def update_and_recount_joined_resources(video_params)
    Video.reset_counters(id, :keywords)
    update(video_params)
  end


  def year
    if date_released
      date_released.year
    end
  end



  private


  def strip_whitespace_edges_from_entered_text
    [ self.copyright_text_markup,
      self.description_text_markup,
      self.involved_people_text_markup,
      self.title,
    ].select{ |a| a.to_s != '' }.each { |a| a.to_s.strip! }
  end


end
