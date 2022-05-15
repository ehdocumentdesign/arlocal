class Public::VideosController < PublicController


  # def index
  #   @videos = QueryVideos.index_public(@arlocal_settings, params)
  # end


  def index
    video_query = QueryVideos.index_public(@arlocal_settings, params)
    case video_query
    when ActiveRecord::Relation, Array
      @videos = video_query
      render :index_array
    when Hash
      @video_groups = video_query
      render :index_hash
    else
      render :index_nil
    end
  end


  def show
    @video = QueryVideos.find_public(params[:id])
    @video_neighbors = QueryVideos.neighborhood_public(@video, @arlocal_settings)
  end


end
