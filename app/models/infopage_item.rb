class InfopageItem < ApplicationRecord


  belongs_to :infopage
  belongs_to :infopageable, polymorphic: true


  protected


  def self.group_options
    [{id: '0', order: '0', position: 'top'},
     {id: '1', order: '1', position: 'left'},
     {id: '2', order: '2', position: 'right'}]
  end


  def self.group_options_for_select
    self.group_options.sort_by{ |o| o[:order] }.map{ |o| [o[:position], o[:id]] }
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


  def is_group(position)
    group = InfopageItem.group_options.select { |o| o[:id] == infopage_group }
    if group == nil
      false
    elsif group == []
      false
    elsif group.any?
      position.to_s == group[0][:position]
    end
  end


  def is_group_left
    is_group(:left)
  end


  def is_group_right
    is_group(:right)
  end


  def is_group_top
    is_group(:top)
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
