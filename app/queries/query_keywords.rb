class QueryKeywords


  protected


  def self.find_admin(id)
    Keyword.friendly.find(id)
  end


  def self.index_admin
    new.index_admin
  end


  def self.neighborhood_admin(keyword)
    new.neighborhood_admin(keyword)
  end


  def self.options_for_select_admin
    new.options_for_select_admin
  end


  public


  def initialize(**args)
  end


  def all
    all_keywords
  end


  def index_admin
    order_by_title_asc
  end


  def neighborhood_admin(keyword, distance: 1)
    Keyword.neighborhood(keyword, collection: index_admin, distance: distance)
  end


  def options_for_select_admin
    order_by_title_asc
  end


  def all_that_select_albums
    keywords.where("albums_count > ?", 0)
  end


  def all_that_select_audio
    all_keywords.where("audio_count > ?", 0).order(title: :asc)
  end


  def all_that_select_admin_pictures
    all_keywords.where("pictures_count > ?", 0).order(title: :asc)
  end


  def all_that_select_public_pictures
    all_keywords.where(can_select_pictures: true).where("pictures_count > ?", 0).order(title: :asc)
  end


  def order_by_slug_asc
    all_keywords.order(Keyword.arel_table[:slug].lower.asc)
  end


  def order_by_slug_desc
    all_keywords.order(Keyword.arel_table[:title].lower.desc)
  end


  def order_by_title_asc
    all_keywords.order(Keyword.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    all_keywords.order(Keyword.arel_table[:title].lower.desc)
  end



  private


  def all_keywords
    Keyword.all.includes(:albums, :audio, :events, :pictures, :videos)
  end


end
