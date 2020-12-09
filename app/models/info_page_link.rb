class InfoPageLink < ApplicationRecord
  
  belongs_to :info_page
  belongs_to :link

  
  ### created_at
  
  
  ### display_method
  
  
  ### id
  
  
  ### info_page_can_display_details
  
  
  ### info_page_order
  
  
  def info_page_will_display_details
    if info_page_can_display_details && link.details_text_markup.to_s != ''
      true
    end
  end
  
    
  # def link_address_href
  #   if link
  #     link.address_href
  #   end
  # end
  #
  #
  def link_address_props
    if link
      link.address_props
    end
  end
  #
  #
  def link_details_props
    if link
      link.details_props
    end
  end
  #
  #
  def link_name
    if link
      link.name
    end
  end
    

  ### updated_at
  
  
end