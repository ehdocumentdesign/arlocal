class QueryArticles


  def initialize(**args)
    # arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @params = args[:params]
  end



  public


  def action_admin_show_neighborhood(article, distance: 1)
    Article.neighborhood(article, collection: @articles, distance: distance)
  end


end
