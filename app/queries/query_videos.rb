class QueryVideos


  protected


  def self.find_admin(id)
    Video.friendly.find(id)
  end


  def self.find_public(id)
    Video.where(published: true).friendly.find(id)
  end


  def self.index_admin(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_admin
  end


  def self.index_public(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_public
  end


  def self.neighborhood_admin(video, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_admin(video)
  end


  def self.neighborhood_public(video, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_public(video)
  end


  def self.options_for_select_admin
    new.order_by_title_asc
  end



  public


  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end


  def all
    all_videos
  end


  def index_admin
    case determine_filter_method_admin
    when 'datetime_asc'
      order_by_datetime_asc
    when 'datetime_desc'
      order_by_datetime_desc
    when 'title_asc'
      order_by_title_asc
    when 'title_desc'
      order_by_title_desc
    else
      all_videos
    end
  end


  def index_public
    case determine_filter_method_public
    when 'datetime_asc'
      order_by_datetime_asc.where(indexed: true, published: true)
    when 'datetime_desc'
      order_by_datetime_desc.where(indexed: true, published: true)
    when 'keyword_datetime_desc'
      sort_by_keyword(order_by_datetime_desc.where(indexed: true, published: true))
    when 'keyword_title_asc'
      sort_by_keyword(order_by_title_asc.where(indexed: true, published: true))
    when 'title_asc'
      order_by_title_asc.where(indexed: true, published: true)
    when 'title_desc'
      order_by_title_desc.where(indexed: true, published: true)
    else
      all_videos.where(indexed: true, published: true)
    end
  end


  def neighborhood_admin(video, distance: 1)
    Video.neighborhood(video, collection: index_admin, distance: distance)
  end


  def neighborhood_public(video, distance: 1)
    Video.neighborhood(video, collection: index_public, distance: distance)
  end


  def options_for_select_admin
    order_by_title_asc
  end


  def order_by_datetime_asc
    all_videos.order(date_released: :asc)
  end


  def order_by_datetime_desc
    all_videos.order(date_released: :desc)
  end


  def order_by_title_asc
    all_videos.order(Video.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    all_videos.order(Video.arel_table[:title].lower.desc)
  end


  def sort_by_keyword(collection)
    result = Hash.new
    Keyword.where(can_select_videos: true).order(order_selecting_videos: :asc).each do |keyword|
      result[keyword.title] = collection.joins(:keywords).where(keywords: keyword)
    end
    result["more videos"] = collection.reject{ |vid| vid.keywords.map { |k| k.can_select_videos }.include?(true) }
    result.delete_if { |k,v| v == [] }
  end



  private


  def all_videos
    Video.all.includes(:keywords, {picture: :source_attachment_attachment})
  end


  def determine_filter_method_admin
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_admin.symbol.to_s.downcase
    end
  end


  def determine_filter_method_public
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_public.symbol.to_s.downcase
    end
  end


  def index_sorter_admin
    SorterIndexAdminVideos.find(@arlocal_settings.admin_index_videos_sorter_id)
  end


  def index_sorter_public
    SorterIndexPublicVideos.find(@arlocal_settings.public_index_videos_sorter_id)
  end


end
