class QueryInfopages


  protected


  def self.get
    Infopage.first
  end


  def self.index_admin
    new.index_admin
  end


  public


  def index_admin
    all_infopages.order(index_order: :asc)
  end


  private


  def all_infopages
    Infopages.all.includes({infopage_items: :infopageable})
  end


end
