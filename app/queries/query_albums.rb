class QueryAlbums


  def initialize(**args)
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.get
    @index_sorter_admin = SorterIndexAdminAlbums.find(arlocal_settings.admin_index_albums_sorter_id)
    @index_sorter_public = SorterIndexAdminAlbums.find(arlocal_settings.public_index_albums_sorter_id)
    @params = args[:params]
  end


  protected


  def self.find(id)
    Album.friendly.find(id)
  end


  def self.find_public(id)
    Album.where(published: true).friendly.find(id)
  end



  public


  def action_admin_destroy
    albums.friendly.find(@params[:id])
  end


  def action_admin_edit
    albums.friendly.find(@params[:id])
  end


  def action_admin_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]
    case filter_method.to_s.downcase
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


  def action_admin_show
    albums.friendly.find(@params[:id])
  end


  def action_admin_show_neighborhood(album, distance: 1)
    Album.neighborhood(album, collection: albums_admin_index_ordered, distance: distance)
  end


  def action_public_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
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


  def action_public_show
    albums.where(published: true).friendly.find(@params[:id])
  end


  def action_public_show_neighborhood(album, distance: 1)
    albums.neighborhood(album, collection: albums_public_index_ordered, distance: distance)
  end


  def all
    albums
  end


  # def find(id)
  #   albums.friendly.find(id)
  # end


  # def find!(id)
  #   @albums.find_by_id!(id)
  # end
  #
  #
  # def find_by_slug(id)
  #   @albums.find_by_slug!(id)
  # end
  #
  #
  # def find_by_slug!(id)
  #   @albums.find_by_slug!(id)
  # end
  #
  #
  # def find_by_slug_with_includes(id)
  #   @albums.includes({audio: :recording_attachment}, :keywords, :pictures).find_by_slug!(id)
  # end
  #
  #
  # def find_including_resources(id)
  #   @albums.includes({audio: :recording_attachment}, :keywords, :pictures).find(id)
  # end


  def order_by_datetime_asc
    albums.order(date_released: :asc)
  end


  def order_by_datetime_desc
    albums.order(date_released: :desc)
  end


  def order_by_title_asc
    albums.order(Album.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    albums.order(Album.arel_table[:title].lower.desc)
  end



  private


  def albums
    Album.all.includes({audio: :recording_attachment}, :keywords, {pictures: :image_attachment})
  end


  def albums_admin_index_ordered
    action_admin_index(@index_sorter_admin.symbol)
  end


  def albums_public_index_ordered
    action_public_index(@index_sorter_public.symbol)
  end


end
