class QueryIsrc


  protected


  def self.review_all(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).review_admin
  end



  public


  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end


  def all
    all_isrcable
  end


  def order_by_class_title_asc
    order_by_title_asc.sort_by { |i| i.class.to_s }
  end


  def order_by_class_title_desc
    order_by_title_desc.sort_by { |i| i.class.to_s }
  end


  def order_by_isrc_asc
    order_by_title_asc.sort_by { |i| i.isrc }
  end


  def order_by_isrc_desc
    order_by_title_asc.sort_by { |i| i.isrc }.reverse
  end


  def order_by_title_asc
    all_isrcable.sort_by { |i| i.title.downcase }
  end


  def order_by_title_desc
    all_isrcable.sort_by { |i| i.title.downcase }.reverse
  end


  def review_admin
    case determine_filter_method_admin
    when 'class_title_asc'
      order_by_class_title_asc
    when 'class_title_desc'
      order_by_class_title_desc
    when 'isrc_asc'
      order_by_isrc_asc
    when 'isrc_desc'
      order_by_isrc_desc
    when 'title_asc'
      order_by_title_asc
    when 'title_desc'
      order_by_title_desc
    else
      all
    end
  end


  private


  def all_isrcable
    result = []
    result << Audio.all.map { |a| a }
    result << Video.all.map { |v| v }
    result.flatten
  end


  def determine_filter_method_admin
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_admin.symbol.to_s.downcase
    end
  end


  def index_sorter_admin
    SorterReviewAdminIsrc.find(@arlocal_settings.admin_review_isrc_sorter_id)
  end


end
