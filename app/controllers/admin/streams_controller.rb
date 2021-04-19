class Admin::StreamsController < AdminController


  def create
    @stream = StreamBuilder.create(stream_params)
    if @stream.save
      flash[:notice] = 'Stream was successfully created.'
      redirect_to edit_admin_stream_path(@stream.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormStreamMetadata.new(pane: params[:pane])
      flash[:notice] = 'Stream could not be created.'
      render 'new'
    end
  end


  def destroy
    @stream = QueryStreams.find(params[:id])
    @stream.destroy
    flash[:notice] = 'Stream was destroyed.'
    redirect_to action: :index
  end


  def edit
    @stream = QueryStreams.find(params[:id])
    @form_metadata = FormStreamMetadata.new(pane: params[:pane])
  end


  def index
    @streams = Stream.all
  end


  def new
    @stream = StreamBuilder.build_with_defaults
    @form_metadata = FormStreamMetadata.new(pane: params[:pane])
  end


  def show
    @stream = QueryStreams.find(params[:id])
  end


  def update
    @stream = QueryStreams.find(params[:id])
    if @stream.update(stream_params)
      flash[:notice] = 'Stream was successfuly updated.'
      redirect_to edit_admin_stream_path(@stream.id_admin, pane: params[:pane])
    else
      @form_metadata = FormStreamMetadata.new(pane: params[:pane])
      flash[:notice] = 'Info Page could not be updated.'
      render 'edit'
    end
  end


  private


  def stream_params
    params.require(:stream).permit(
      :description_parser_id,
      :description_text_markup,
      :html_element,
      :indexed,
      :published,
      :slug,
      :title
    )
  end


end
