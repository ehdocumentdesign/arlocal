class FormMetadataSelectable


  include FormMetadataSelectablesUtils
  attr_reader(
    :albums,
    :articles,
    :audio,
    :events,
    :keywords,
    :links,
    :markup_parsers,
    :pictures,
    :videos
  )


  def initialize(selectable, arlocal_settings)
    selectable.each_pair do |k,v|
      instance_variable_set(k, v.call(arlocal_settings))
    end
  end


  public


  def does_have_albums
    if (@albums == nil)
      false
    else
      @albums.any?
    end
  end


  def does_have_articles
    if (@articles == nil)
      false
    else
      @articles.any?
    end
  end


  def does_have_audio
    if (@audio == nil)
      false
    else
      @audio.any?
    end
  end


  def does_have_events
    if (@events == nil)
      false
    else
      @events.any?
    end
  end


  def does_have_keywords
    if (@keywords == nil)
      false
    else
      @keywords.any?
    end
  end


  def does_have_links
    if (@links == nil)
      false
    else
      @links.any?
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
    else
      @videos.any?
    end
  end


end
