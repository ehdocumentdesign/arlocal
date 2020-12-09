class Stream < ApplicationRecord
  
  
  before_validation :strip_whitespace_edges_from_entered_text
  before_validation :ensure_critical_attributes_have_default_values
  
  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\_\-]*\z/ }
  
  
  public
  
  
  def description
    { parser_id: description_parser_id, text_markup: description_text_markup }
  end
  
  
  ### description_parser_id
  
  
  ### description_text_markup
  
  
  ### html_element
  
  
  def html_element_conditionally
    if published
      html_element.html_safe
    else
      html_element
    end
  end
  
  
  ### id
  
  
  def id_admin
    slug
  end
  
  
  def id_public
    slug
  end
  
  
  ### published
  
  
  ### slug
  
  
  def slug_source
    'title'
  end
  
  
  ### title
  
  
  
  private
  
  
  def ensure_critical_attributes_have_default_values
    if self.slug.to_s == ''
      self.slug = self.title.to_s.parameterize
    end
  end

  
  def strip_whitespace_edges_from_entered_text
    [ self.html_element,
      self.slug,
      self.title,
    ].select{ |a| a.to_s != '' }.each { |a| a.to_s.strip! }
  end
  
  
end