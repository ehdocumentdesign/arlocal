class Stream < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  friendly_id :slug_candidates, use: :slugged

  before_validation :strip_whitespace_edges_from_entered_text

  validates :title, presence: true, uniqueness: true



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
    friendly_id
  end


  def id_public
    friendly_id
  end


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


  ### title



  private


  def strip_whitespace_edges_from_entered_text
    [ self.html_element,
      self.title,
    ].select{ |a| a.to_s != '' }.each { |a| a.to_s.strip! }
  end


end
