class Public::StreamsController < PublicController


  def index
    if Stream.count == 1
      redirect_to action: :show
    else
      @streams = Stream.all
      render 'index'
    end
  end


  def show
    if params[:id]
      @stream = QueryStreams.new.find_by_slug(params[:id])
    else
      @stream = Stream.first!
      params.merge!({id: @stream.slug})
    end
  end


end
