class Public::VideosController < PublicController


  def index
    @videos = QueryVideos.index_public(@arlocal_settings, params)
  end


  def show
    @video = QueryVideos.find_public(params[:id])
    @video_neighbors = QueryVideos.neighborhood_public(@video, @arlocal_settings)
  end


end
