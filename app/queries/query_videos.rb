class QueryVideos


  def initialize(**args)
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.get
    @index_sorter_admin = SorterIndexAdminVideos.find(arlocal_settings.admin_index_videos_sorter_id)
    @index_sorter_public = SorterIndexPublicVideos.find(arlocal_settings.public_index_videos_sorter_id)
    @params = args[:params]
  end



  protected


  def self.find(id)
    Video.friendly.find(id)
  end


  def self.find_public(id)
    Video.where(published: true).friendly.find(id)
  end



  public


  def action_admin_edit
    videos.friendly.find(@params[:id])
  end


  # def action_admin_index
  #   Video.all
  # end


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
    videos.friendly.find(@params[:id])
  end


  def action_public_show_neighborhood(video, distance: 1)
    videos.neighborhood(video, collection: videos_admin_index_ordered, distance: distance)
  end


  # def action_public_index
  #   Video.all.where(indexed: true, published: true)
  # end


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
    videos.where(indexed: true, published: true).friendly.find(@params[:id])
  end


  def action_admin_show_neighborhood(video, distance: 1)
    videos.neighborhood(video, collection: videos_public_index_ordered, distance: distance)
  end


  def all
    videos
  end


  def find
    videos.friendly.find(@params[:id])
  end


  def order_by_datetime_asc
    videos.order(date_released: :asc)
  end


  def order_by_datetime_desc
    videos.order(date_released: :desc)
  end


  # def order_by_title_asc
  #   Video.all.sort_by{ |v| v.title.downcase  }
  # end


  def order_by_title_asc
    videos.order(Video.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    videos.order(Video.arel_table[:title].lower.desc)
  end



  private


  def videos
    Video.all.includes({picture: :image_attachment})
  end


  def videos_admin_index_ordered
    action_admin_index(@index_sorter_admin.symbol)
  end


  def videos_public_index_ordered
    action_public_index(@index_sorter_public.symbol)
  end


end
