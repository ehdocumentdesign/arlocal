class Public::VideosController < PublicController


  def show
    @video = Video.new
  end


end
