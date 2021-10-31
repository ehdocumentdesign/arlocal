class QueryInfopages


  protected


  def self.find_admin(id)
    Infopage.friendly.find(id)
  end


  def self.find_public(id)
    Infopage.friendly.find(id)
  end


  def self.first_public
    Infopage.order(index_order: :asc).first!
  end


  def self.index_admin
    new.index_admin
  end


  def self.neighborhood_admin(infopage, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_admin(infopage)
  end


  public


  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end


  def index_admin
    all_infopages.order(index_order: :asc)
  end


  def neighborhood_admin(infopage, distance: 1)
    Event.neighborhood(infopage, collection: index_admin, distance: distance)
  end


  private


  def all_infopages
    Infopage.all.includes({infopage_items: :infopageable})
  end


end
