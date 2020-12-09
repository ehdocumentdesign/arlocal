class InfoPage < ApplicationRecord

  
  belongs_to :article, optional: true
  belongs_to :picture, optional: true
    
  has_many :info_page_links, -> { order(:info_page_order) }, dependent: :destroy
  has_many :links, through: :info_page_links

  accepts_nested_attributes_for :info_page_links, allow_destroy: true
  

  public
  
    
  ### article_id
  
  
  def article_text_props
    if article
      article.text_props
    end
  end
  
  
  ### created_at
  
  
  def has_article
    if article
      true
    end
  end
  
  
  def has_links
    links.count.to_i > 0
  end
  
  
  def has_picture
    if picture
      true
    end
  end
  
  
  ### id
  
  
  ### picture_id
  
  
  ### updated_at
  
  
end