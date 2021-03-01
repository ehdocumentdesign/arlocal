class QueryLinks


  def initialize(**args)
    # arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @params = args[:params]
  end



  public


  def action_admin_show_neighborhood(link, distance: 1)
    Link.neighborhood(link, collection: @links, distance: distance)
  end


end
