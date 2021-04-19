class QueryKeywords


  def initialize(**args)
  end


  protected


  def self.find(id)
    Keyword.friendly.find(id)
  end


  public


  def action_admin_edit(id)
    Keyword.friendly.find(id)
  end


  def action_admin_index
    order_by_title_asc
  end


  def action_admin_show(id)
    Keyword.friendly.find(id)
  end


  def action_admin_show_neighborhood(keyword, distance: 1)
    Keyword.neighborhood(keyword, collection: Keyword.all, distance: distance)
  end


  def action_admin_update(id)
    Keyword.friendly.find(id)
  end


  def all_that_select_albums
    keywords.where("albums_count > ?", 0)
  end


  def all_that_select_audio
    keywords.where("audio_count > ?", 0).order(title: :asc)
  end


  def all_that_select_admin_pictures
    keywords.where("pictures_count > ?", 0).order(title: :asc)
  end


  def all_that_select_public_pictures
    keywords.where(can_select_pictures: true).where("pictures_count > ?", 0).order(title: :asc)
  end


  def find(id)
    keywords.friendly.find(id)
  end


  def order_by_slug_asc
    keywords.order(Keyword.arel_table[:slug].lower.asc)
  end


  def order_by_slug_desc
    keywords.order(Keyword.arel_table[:title].lower.desc)
  end


  def order_by_title_asc
    keywords.order(Keyword.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    keywords.order(Keyword.arel_table[:title].lower.desc)
  end



  private


  def keywords
    Keyword.all.includes(:albums, :audio, :events, :pictures, :videos)
  end


end
