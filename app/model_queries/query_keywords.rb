class QueryKeywords


  def initialize(args = {})
    @keywords = Keyword.all
  end


  public


  def action_admin_edit(id)
    find_by_slug!(id)
  end


  def action_admin_index
    order_by_title_asc
  end


  def action_admin_show_neighborhood(keyword, distance: 1)
    Keyword.neighborhood(keyword, collection: all, distance: distance)
  end


  def all
    @keywords
  end


  def all_that_select_albums
    @keywords.where("albums_count > ?", 0)
  end


  def all_that_select_audio
    @keywords.where("audio_count > ?", 0).order(title: :asc)
  end


  def all_that_select_admin_pictures
    @keywords.where("pictures_count > ?", 0).order(title: :asc)
  end


  def all_that_select_public_pictures
    @keywords.where(can_select_pictures: true).where("pictures_count > ?", 0).order(title: :asc)
  end


  def find(id)
    @keywords.friendly.find(id)
  end


  def find_by_slug(slug)
    @keywords.friendly.find(id)
  end


  def find_by_slug!(slug)
    @keywords.friendly.find(id)
  end


  def order_by_slug_asc
    @keywords.order(Keyword.arel_table[:slug].lower.asc)
  end


  def order_by_slug_desc
    @keywords.order(Keyword.arel_table[:title].lower.desc)
  end


  def order_by_title_asc
    @keywords.order(Keyword.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    @keywords.order(Keyword.arel_table[:title].lower.desc)
  end


end
