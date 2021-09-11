class QueryLinks


  protected


  def self.find_admin(id)
    Link.find(id)
  end


  def self.index_admin
    new.index_admin
  end


  def self.neighborhood_admin(link)
    new.neighborhood_admin(link)
  end


  def self.options_for_select_admin
    new.options_for_select_admin
  end


  public


  def initialize(**args)
    @params = args[:params]
  end


  def index_admin
    Link.all
  end


  def neighborhood_admin(link, distance: 1)
    Link.neighborhood(link, collection: index_admin, distance: distance)
  end


  def options_for_select
    Link.all
  end


  def options_for_select_admin
    Link.all
  end

end
