module FormMetadataSelectablesUtils


  def does_have_albums
    if (@albums == nil)
      false
    elsif (@albums.length == 0)
      false
    elsif (@albums.length >= 1)
      true
    end
  end


  def does_have_audio
    if (@audio == nil)
      false
    elsif (@audio.length == 0)
      false
    elsif (@audio.length >= 1)
      true
    end
  end


  def does_have_events
    if (@events == nil)
      false
    elsif (@events.length == 0)
      false
    elsif (@events.length >= 1)
      true
    end
  end


  def does_have_keywords
    if (@keywords == nil)
      false
    elsif (@keywords.length == 0)
      false
    elsif (@keywords.length >= 1)
      true
    end
  end


  def does_have_pictures
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


  def does_have_videos
    if (@videos == nil)
      false
    elsif (@videos.length == 0)
      false
    elsif (@videos.length >= 1)
      true
    end
  end


end
