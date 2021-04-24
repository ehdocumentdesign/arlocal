class Public::StreamsController < PublicController


  def index
    if Stream.count == 1
      redirect_to action: :show
    else
      @streams = QueryStreams.index_public
      render 'index'
    end
  end


  def show
    if params[:id]
      @stream = QueryStreams.find_public(params[:id])
    else
      @stream = Stream.first!
      params.merge!({id: @stream.id})
    end
  end


end
