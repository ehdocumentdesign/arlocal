class QueryAlbums


  # Controllers should call a singleton method, to maintain the look and feel of
  # the ActiveRecord Query Interface.
  #
  # If a singleton menthod requires interpretation of data, the singleton
  # method will create and utilize an instance object.


  protected


  def self.find_admin(id)
    Album.friendly.find(id)
  end


  def self.find_public(id)
    Album.where(published: true).friendly.find(id)
  end


  def self.index_admin(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_admin
  end


  def self.index_public(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_public
  end


  def self.neighborhood_admin(album, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_admin(album)
  end


  def self.neighborhood_public(album, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_public(album)
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
    all_albums
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
      all
    end
  end


  def index_public
    case determine_filter_method_public
    when 'datetime_asc'
      order_by_datetime_asc.where(indexed: true, published: true)
    when 'datetime_desc'
      order_by_datetime_desc.where(indexed: true, published: true)
    when 'title_asc'
      order_by_title_asc.where(indexed: true, published: true)
    when 'title_desc'
      order_by_title_desc.where(indexed: true, published: true)
    else
      all.where(indexed: true, published: true)
    end
  end


  def neighborhood_admin(album, distance: 1)
    Album.neighborhood(album, collection: index_admin, distance: distance)
  end


  def neighborhood_public(album, distance: 1)
    Album.neighborhood(album, collection: index_public, distance: distance)
  end


  def order_by_datetime_asc
    all_albums.order(date_released: :asc)
  end


  def order_by_datetime_desc
    all_albums.order(date_released: :desc)
  end


  def order_by_title_asc
    all_albums.order(Album.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    all_albums.order(Album.arel_table[:title].lower.desc)
  end



  private


  def all_albums
    Album.all.includes({audio: :source_attachment_attachment}, :keywords, {pictures: :source_attachment_attachment})
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
    SorterIndexAdminAlbums.find(@arlocal_settings.admin_index_albums_sorter_id)
  end


  def index_sorter_public
    SorterIndexPublicAlbums.find(@arlocal_settings.public_index_albums_sorter_id)
  end


end
