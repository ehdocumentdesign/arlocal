class InfopageItem < ApplicationRecord


  belongs_to :infopage
  belongs_to :infopageable, polymorphic: true


  public


  ### infopage_id


  def infopage_group
    infopage_order_parsed[:group]
  end


  ### infopage_order


  def infopage_order_within_group
    infopage_order_parsed[:order_with_group]
  end


  ### infopageable_id


  ### infopageable_type


  def is_article
    infopageable_type == 'Article'
  end


  def is_group?(group)
    infopage_group == group.to_s
  end


  def is_link
    infopageable_type == 'Link'
  end


  def is_picture
    infopageable_type == 'Picture'
  end
  

  def title
    self.infopageable
  end


  def type_of
    infopageable_type
  end



  private


  def infopage_order_parsed
    parsed_order = infopage_order.match /\A(\D*)(\d*)\z/
    { group: parsed_order[1].to_s.downcase, order_within_group: parsed_order[2].to_i }
  end


end
