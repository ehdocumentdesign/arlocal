class Public::AudioController < PublicController


  def index
    redirect_to :root
  end


  def show
    @audio = QueryAudio.find_public(params[:id])
  end


end
