class Public::VideosController < PublicController


  def index
    @videos = QueryVideos.new(params: params).action_public_index
  end


  def show
    @video = QueryVideos.new(params: params).action_public_show
  end


end
