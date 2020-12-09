class Public::AudioController < PublicController


  def index
    redirect_to :root
  end


  def show
    @audio = QueryAudio.new.find(params[:id])
  end


end
