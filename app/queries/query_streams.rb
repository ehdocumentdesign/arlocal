class QueryStreams


  protected


  def self.find_admin(id)
    Stream.find_by_slug(id)
  end


  def self.find_public(id)
    Stream.where(published: true).find(id)
  end


  def self.index_admin
    new.index_admin
  end


  def self.neighborhood_admin(stream)
    new.neighborhood_admin(stream)
  end


  def self.options_for_select_admin
    new.options_for_select_admin
  end


  public


  def initialize
  end


  def index_admin
    Stream.all
  end


  def neighborhood_admin(stream, distance: 1)
    Stream.neighborhood(stream, collection: index_admin, distance: distance)
  end


  def options_for_select_admin
    index_admin
  end


end
