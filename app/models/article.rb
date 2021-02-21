class Article < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  validates :copyright_parser_id, presence: true
  validates :parser_id, presence: true


  public


  ### author


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ### copyright_parser_id


  ### copyright_text_markup


  ### created_at


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### indexed


  ### parser_id


  ### date_released


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


  def text_props
    { parser_id: parser_id, text_markup: text_markup }
  end


  ### text_markup


  ### title


  ### updated_at


end
