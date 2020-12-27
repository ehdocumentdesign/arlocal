class Article < ApplicationRecord


  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable


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
    id
  end


  def id_public
    id
  end


  ### indexed


  ### parser_id


  ### date_released


  def text_props
    { parser_id: parser_id, text_markup: text_markup }
  end


  ### text_markup


  ### title


  ### updated_at


end
