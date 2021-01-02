module FormMetadataSelectablesUtils


  def has_keywords
    if (@keywords == nil)
      false
    elsif (@keywords.length == 0)
      false
    elsif (@keywords.length >= 1)
      true
    end
  end


  def has_pictures
    if (@pictures == nil)
      false
    elsif (@pictures.length == 0)
      false
    elsif (@pictures.length == 1) && (@pictures[0].id == nil)
      false
    elsif (@pictures.length == 1) && (Integer === @pictures[0].id)
      true
    elsif (@pictures.length >= 2)
      true
    end
  end


end