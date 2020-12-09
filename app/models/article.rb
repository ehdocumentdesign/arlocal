class Article < ApplicationRecord


  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable
  

  validates :parser_id, presence: true
  
    
  public
  
  
  ### author


  ### copyright_notice

  
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