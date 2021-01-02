class Video < ApplicationRecord


  before_validation :strip_whitespace_edges_from_entered_text
  before_validation :ensure_critical_attributes_have_default_values


  has_many :video_keywords, dependent: :destroy
  has_many :keywords, through: :video_keywords

  has_one :video_picture, dependent: :destroy
  has_one :picture, through: :video_picture

  has_one_attached :recording

  accepts_nested_attributes_for :video_keywords, allow_destroy: true, reject_if: proc { |attributes| attributes['keyword_id'] == '0' }
  accepts_nested_attributes_for :video_picture



  protected


  def self.source_type_options
    [:attachment, :catalog, :url]
  end


  def self.source_type_options_for_select
    Video.source_type_options.map{ |option| [option, option] }
  end



  public


  #############
  def copyright_parser_id
    4
  end


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ##################
  def copyright_text_markup
    'Copyright'
  end


  ##############
  def date_released
    Date.current
  end


  ####################
  def description_parser_id
    4
  end


  def description_props
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end


  ####################
  def description_text_markup
    'Description'
  end


  def display_dimension_width
    640
  end


  def display_dimension_height
    (source_dimension_height * display_dimension_width) / source_dimension_width
  end


  # iiiiiiiiiiiiiiiiiiiiiii
  def id
    1
  end


  def id_admin
    id
  end


  def id_public
    id
  end


  ###################
  def indexed
    true
  end


  ######################
  def involved_people_parser_id
    4
  end


  def involved_people_props
    { parser_id: involved_people_parser_id, text_markup: involved_people_text_markup }
  end


  ######################
  def involved_people_text_markup
    'Involved people'
  end

  #############
  def picture_id
  end


  #####################
  def published
    true
  end


  ######################
  def slug
    'title'
  end


  def slug_source
    :title
  end


  # ?????????????????
  def source_attachment_file_path
  end


  ######################
  def source_catalog_file_path
    'yourallgay.mp4'
  end


  ######################
  def source_dimension_height
    880
  end


  ###################
  def source_dimension_width
    956
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
    when :attachment
      source_attachment_file_path
    when :catalog
      source_catalog_file_path
    when :url
      false
    end
  end


  def source_is_file
    case source_type
    when :attachment
      true
    when :catalog
      true
    else
      false
    end
  end


  def source_is_url
    case source_type
    when :url
      true
    else
      false
    end
  end


  ###################
  def source_type
    # :attachment
    # :catalog
    # :url
    :catalog
  end


  ###################
  def source_url
    'https://www.youtube.com/embed/rmuPs0uCe3w'
  end


  def thumbnail
  end


  ###################
  def title
    'Title'
  end



  private


  def ensure_critical_attributes_have_default_values
    if self.slug.to_s == ''
      self.slug = self.title.to_s.parameterize
    end
  end


  def strip_whitespace_edges_from_entered_text
    [ self.copyright_text_markup,
      self.description_text_markup,
      self.involved_people_text_markup,
      self.slug,
      self.title,
    ].select{ |a| a.to_s != '' }.each { |a| a.to_s.strip! }
  end



end
