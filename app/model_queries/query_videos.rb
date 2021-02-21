class QueryVideos


  def initialize(args = {})
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @index_sorter_admin = SorterIndexAdminVideos.find(arlocal_settings.admin_index_videos_sorter_id)
    @index_sorter_public = SorterIndexAdminVideos.find(arlocal_settings.public_index_videos_sorter_id)
    @params = args[:params]
  end



  public


  def action_admin_edit
    Video.friendly.find(@params[:id])
  end


  def action_admin_index
    Video.all
  end


  def action_admin_show
    Video.friendly.find(id)(@params[:id])
  end


  def action_public_index
    Video.all.where(indexed: true, published: true)
  end


  def action_public_show
    Video.where(indexed: true, published: true).friendly.find(@params[:id])
  end


  def find
    Video.friendly.find(id)(@params[:id])
  end



end
