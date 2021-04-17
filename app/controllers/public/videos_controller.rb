class Public::VideosController < PublicController


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexPublicVideos.find(@arlocal_settings.public_index_videos_sorter_id).symbol
    end
    @videos = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_public_index
  end


  def show
    @video = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_public_show
    @video_neighbors = QueryVideos.new(arlocal_settings: @arlocal_settings).action_public_show_neighborhood(@video)
  end


end
