class InfopageItem < ApplicationRecord


  belongs_to :infopage
  belongs_to :infopageable, polymorphic: true


  protected

  def self.group_options
    ['top','left','right']
  end



  public


  ### infopage_id


  ### infopage_group


  ### infopage_group_order


  ### infopageable_id


  ### infopageable_type


  def is_article
    infopageable_type == 'Article'
  end


  def is_group_left
    infopage_group == 'left'
  end


  def is_group_right
    infopage_group == 'right'
  end


  def is_group_top
    infopage_group == 'top' || infopage_group.to_s == ''
  end


  def is_link
    infopageable_type == 'Link'
  end


  def is_picture
    infopageable_type == 'Picture'
  end


  def picture
    if is_picture
      infopageable
    end
  end
  

  def picture_id
    if is_picture
      infopageable_id
    end
  end


  def title
    self.infopageable.title
  end


  def type_of
    infopageable_type
  end


end
