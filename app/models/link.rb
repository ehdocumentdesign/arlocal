class Link < ApplicationRecord


  extend MarkupParserUtils
  extend Neighborable
  include Seedable
  
  
  before_validation :strip_whitespace_edges_from_entered_text
  
  validates :details_parser_id, presence: true
  
  has_many :info_page_links, dependent: :destroy
  
  accepts_nested_attributes_for :info_page_links, allow_destroy: true
  
  
  
  
  public  
  
  
  
  ### addresss_href
  
  
  def address_href_domain
    address_href.split('@')[1]
  end
  
  
  def address_href_hashed
    { recipient: address_href_recipient, domain: address_href_domain }
  end

  
  def address_href_recipient
    address_href.gsub(/\Amailto:/i, '').split('@')[0]
  end
  
  
  ### address_inline_text


  def address_props
    {
      address_href: address_href,
      address_inline_text: address_inline_text,
      # address_type: address_type,
      details_parser_id: details_parser_id,
      details_text_markup: details_text_markup,
      name: name,
    }
  end
  
  
  ### address_type
  # :email, :web
  # used in app/helpers/link_helper.rb
  
  
  def address_type
    if /\Ahttps?:\/\// =~ address_href.to_s
      :web
    elsif /\Amailto:/ =~ address_href.to_s
      :email
    end
  end
    

  
  ### created_at
  
  
  ### details_parser_id


  def details_props
    { parser_id: details_parser_id, text_markup: details_text_markup }
  end
  
    
  ### details_text_markup
  
  
  # => ### display_method
  #    # 'name_and_address'
  #    # 'address_only'



  def does_have_address_inline_text
    address_inline_text.to_s != ''
  end


  def does_not_have_address_inline_text
    address_inline_text.to_s == ''
  end
  
  
  def effective_inline_text
    if does_have_address_inline_text
      address_inline_text
    elsif does_not_have_address_inline_text
      address_href 
    end
  end
  
  
  ### id
  
  
  def id_admin
    id
  end
  
  
  def id_public
    id
  end
    

  ### name


  def title
    name
  end
  

  ### updated_at
  

  
  private
  
  
  def strip_whitespace_edges_from_entered_text
    [ self.address_href,
      self.address_inline_text,
      self.details_text_markup,
      self.name
    ].each { |a| a.to_s.strip! }
  end

    
end