class Public::VideosController < PublicController


  def index
    determine_index_sorting
    @videos = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_public_index
  end


  def show
    @video = QueryVideos.find_public(params[:id])
    @video_neighbors = QueryVideos.new(arlocal_settings: @arlocal_settings).action_public_show_neighborhood(@video)
  end


  private


  def determine_index_sorting
    if params[:filter] == nil
      params[:filter] = SorterIndexPublicVideos.find(@arlocal_settings.public_index_videos_sorter_id).symbol
    end
  end
  

end
