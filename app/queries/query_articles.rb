class QueryArticles


  def initialize(**args)
    @params = args[:params]
  end


  protected


  def self.find(id)
    Article.friendly.find(id)
  end


  public


  def action_admin_show_neighborhood(article, distance: 1)
    Article.neighborhood(article, collection: articles, distance: distance)
  end


  private


  def articles
    Article.all
  end
  

end
